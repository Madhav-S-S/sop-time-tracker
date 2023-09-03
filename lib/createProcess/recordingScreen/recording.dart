import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class RecordingPage extends StatefulWidget {
  final List<Map<String, String>> variableList;

  RecordingPage({required this.variableList});

  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  bool _isPlaying = false;
  int _selectedIndex = -1;
  int _prevSelectedIndex = -1;
  int _actionCount = 0;
  DateTime? _startTime;
  Map<int, String> _lastActionMap = {};
  Stream<DateTime> _timeStream =
      Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());

  // Timer to update action time every second
  Timer? _actionTimeTimer;
  // Flag to track if action time has started
  bool _actionTimeStarted = false;

  // List to store the action times for each item
  List<String> _itemActionTimes = [];

  // Variable to store the previous lapsed time
  String _previousLapsedTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 5),
        child: AppBar(
          title: Row(
            children: [
              Icon(Icons.mic, size: 30),
              SizedBox(width: 5),
              Text('Recording Page'),
            ],
          ),
          backgroundColor: Color(0xFF1C1D1C),
          automaticallyImplyLeading: false,
          actions: [
            SizedBox(width: 2),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: _handlePauseButtonPress,
                icon: Icon(
                  _isPlaying ? Icons.stop : Icons.play_arrow,
                  color: Color(0xFF1C1D1C),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.edit, color: Color(0xFF1C1D1C)),
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
      backgroundColor: Color(0xFF1C1D1C),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1),
          Container(
            padding: EdgeInsets.all(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<DateTime>(
                  stream: _timeStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _buildWhiteBox(
                        "Current Time",
                        _formatTime(snapshot.data!),
                      );
                    } else {
                      return _buildWhiteBox("Current Time", "");
                    }
                  },
                ),
                _buildWhiteBox("Action Time", _getActionTimeText()),
                _buildWhiteBox("Lapsed Time", _previousLapsedTime), // Display previous lapsed time
              ],
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
            padding: EdgeInsets.all(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWhiteBox("Last Action", _getLastActionText()),
                _buildWhiteBox("Action Count", _actionCount.toString()),
                _buildWhiteBox("Start Time", _formatTime(_startTime)),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 135 / 70,
              ),
              itemCount: widget.variableList.length,
              itemBuilder: (context, index) {
                final variableItem = widget.variableList[index];
                final variableName = variableItem['name']!;
                final variableType = variableItem['type']!;

                bool isSelected = _selectedIndex == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _prevSelectedIndex = _selectedIndex;
                      _selectedIndex = isSelected ? -1 : index;
                      if (isSelected) {
                        _actionCount++;
                        if (_startTime == null || _prevSelectedIndex == -1) {
                          _startTime = DateTime.now();
                        }
                        _startActionTime();
                      }
                      if (_prevSelectedIndex != -1) {
                        _lastActionMap[_selectedIndex] =
                            widget.variableList[_prevSelectedIndex]['name']!;
                        _storeItemActionTime();
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.black
                          : (variableType == 'Waste'
                              ? Colors.red
                              : Colors.green),
                      border: isSelected
                          ? Border.all(color: Colors.red, width: 1)
                          : null,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '$variableName',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handlePauseButtonPress() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        if (_pauseTime != null) {
          // Calculate the difference and add it to the start time
          final pausedDuration = DateTime.now().difference(_pauseTime!);
          if (_startTime != null) {
            _startTime = _startTime!.add(pausedDuration);
          }
        } else {
          _startTime = DateTime.now();
        }

        if (!_actionTimeStarted) {
          _startActionTime();
          _actionTimeStarted = true;
        }
      } else {
        _actionCount = 0;
        _actionTimeStarted = false;

        // Stop the action time timer when pausing
        _actionTimeTimer?.cancel();

        // Store pause time
        _pauseTime = DateTime.now();
      }
    });
  }

  Widget _buildWhiteBox(String title, String? text) {
    return Container(
      width: 135,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            text ?? '',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time != null) {
      return DateFormat('HH:mm:ss').format(time);
    } else {
      return '';
    }
  }

  String _getLastActionText() {
    return _lastActionMap[_selectedIndex] ?? '';
  }

  void _startActionTime() {
    _actionTimeTimer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (_startTime != null) {
          final currentTime = DateTime.now();
          final difference = currentTime.difference(_startTime!);
          _previousLapsedTime = _formatDuration(difference);
        }
      });
    });
  }

  String _getActionTimeText() {
    if (_selectedIndex != -1 && _startTime != null) {
      final currentTime = DateTime.now();
      final difference = currentTime.difference(_startTime!);
      return _formatDuration(difference);
    } else {
      return '';
    }
  }

  void _storeItemActionTime() {
    if (_selectedIndex != -1 && _startTime != null) {
      final currentTime = DateTime.now();
      final difference = currentTime.difference(_startTime!);
      _itemActionTimes.add(_formatDuration(difference));
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  DateTime? _pauseTime; // Store the pause time

  @override
  void dispose() {
    // Cancel the action time timer when disposing of the widget
    _actionTimeTimer?.cancel();
    super.dispose();
  }
}
