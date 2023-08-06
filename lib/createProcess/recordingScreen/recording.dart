import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordingPage extends StatefulWidget {
  final List<Map<String, String>> variableList;

  RecordingPage({required this.variableList});

  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  bool _isPlaying = false;
  int _selectedIndex = -1; // Initialize selected index to -1 (no selection)
  int _prevSelectedIndex = -1; // Keep track of previously selected index
  int _actionCount = 0;
  String _startTime = '';
  Map<int, String> _lastActionMap = {}; // Map to store last actions

  // A stream that emits a value every second
  Stream<DateTime> _timeStream =
  Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());

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
                onPressed: _handlePauseButtonPress, // Use the new method
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
                          "Current Time", _formatTime(snapshot.data!));
                    } else {
                      return _buildWhiteBox("Current Time", "");
                    }
                  },
                ),
                _buildWhiteBox("Action Time", ""),
                _buildWhiteBox("Lapsed Time", ""),
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
                _buildWhiteBox("Start Time", _startTime),
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
                childAspectRatio: 135 / 70, // Set the aspect ratio of each item
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
                      }
                      if (_prevSelectedIndex != -1) {
                        // Store the last variable name for the previously selected item
                        _lastActionMap[_selectedIndex] = widget.variableList[_prevSelectedIndex]['name']!;
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
                      border: isSelected ? Border.all(color: Colors.red, width: 1) : null,
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
        _startTime = _formatTime(DateTime.now());
      } else {
        // Reset the action count when the pause button is pressed
        _actionCount = 0;
      }
    });
  }

  Widget _buildWhiteBox(String title, String text) {
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
            text,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat('HH:mm:ss').format(time);
  }

  String _getLastActionText() {
    // Return the last variable name for the selected item
    return _lastActionMap[_selectedIndex] ?? ''; // Provide a default value for null case
  }
}
