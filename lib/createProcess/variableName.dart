import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/model.dart';
import 'processName.dart';

class VariableNamePage extends StatefulWidget {
  @override
  _VariableNamePageState createState() => _VariableNamePageState();
}

class _VariableNamePageState extends State<VariableNamePage> {
  String _selectedTaskType =
      'Task'; // Initialize the selected task type to 'Task'
  List<Map<String, dynamic>> _variableList = [];
  TextEditingController _variableNameController = TextEditingController();
  Future<void> _createItem(String name, String type) async {
    Data newItem = Data(name: name, type: type);
    final box = Hive.box('processes');
    await box.add(newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Variable Name Page'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF29D1B4),
      ),
      backgroundColor: Color(0xFF1C1D1C), // Set background color to #1c1d1c
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            TextField(
              controller: _variableNameController,
              style: TextStyle(
                color: Color(0xFFF9F9F9),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF1C1D1C),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0xFF2DD3B3), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0xFF2DD3B3), width: 2),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                isDense: true,
                hintText: 'Variable Name',
                hintStyle: TextStyle(
                  color: Color(0xFF2DD3B3),
                ),
                prefixIcon: Icon(
                  Icons.list,
                  color: Color(0xFF2DD3B3),
                ),
              ),
              cursorColor: Color(0xFFF9F9F9),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () => _showTaskTypeMenu(),
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF1C1D1C),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Color(0xFF2DD3B3), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Color(0xFF2DD3B3), width: 2),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  isDense: true,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedTaskType,
                      style: TextStyle(
                        color: Color(0xFF2DD3B3),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF2DD3B3),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 150,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  // Add the logic for the ADD button here
                  _addVariable();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF2DD3B3)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                  ),
                ),
                child: Text(
                  'ADD',
                  style: TextStyle(
                    color: Color(0xFF1C1D1C),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      for (int i = 0; i < _variableList.length; i++)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: _buildVariableItem(i),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF1C1D1C),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFE73A37)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  child: Text('CANCEL'),
                ),
              ),
            ),
            SizedBox(width: 4.0),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Next button clicked');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF29D1B4)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  child: Text('NEXT'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTaskTypeMenu() {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomLeft(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final menuItems = <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: 'Task',
        child: Text(
          'Task',
          style: TextStyle(color: Color(0xFF2DD3B3)),
        ),
      ),
      PopupMenuItem<String>(
        value: 'Waste',
        child: Text(
          'Waste',
          style: TextStyle(color: Color(0xFF2DD3B3)),
        ),
      ),
    ];

    showMenu<String>(
      context: context,
      position: position,
      items: menuItems,
    ).then((newValue) {
      if (newValue != null) {
        setState(() {
          _selectedTaskType = newValue;
        });
      }
    });
  }

  void _addVariable() async {
    _createItem(_variableNameController.text, _selectedTaskType);

    final variableName = _variableNameController.text.trim();
    if (variableName.isNotEmpty) {
      setState(() {
        _variableList.add({
          'name': variableName,
          'type': _selectedTaskType,
        });
        _variableNameController.clear();
      });
    }
  }

  void _removeVariable(int index) {
    setState(() {
      _variableList.removeAt(index);
    });
  }

  Widget _buildVariableItem(int index) {
    final variableItem = _variableList[index];
    final variableName = variableItem['name']!;
    final variableType = variableItem['type']!;

    TextSpan nameSpan =
        TextSpan(text: variableName, style: TextStyle(color: Colors.white));
    TextSpan typeSpan;

    if (variableType == 'Waste') {
      typeSpan = TextSpan(text: 'Waste', style: TextStyle(color: Colors.red));
    } else if (variableType == 'Task') {
      typeSpan = TextSpan(text: 'Task', style: TextStyle(color: Colors.green));
    } else {
      typeSpan =
          TextSpan(text: variableType, style: TextStyle(color: Colors.white));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 50, // You can adjust the height as needed
      decoration: BoxDecoration(
        // Add a BoxDecoration with border for each GridView item
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [nameSpan],
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [typeSpan],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _removeVariable(index),
                  icon: Icon(Icons.remove_circle, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    // Implement the logic for editing the variable item here
                    print('Edit button clicked for index $index');
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
