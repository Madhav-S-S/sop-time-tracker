import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import the fluttertoast package
import 'package:hive/hive.dart';
import 'variableName.dart';

class ProcessNamePage extends StatefulWidget {



  @override
  _ProcessNamePageState createState() => _ProcessNamePageState();
}

class _ProcessNamePageState extends State<ProcessNamePage> {
  TextEditingController processNameController =
      TextEditingController(); // Create a controller for the text field
  bool _isProcessNameValid = false; // Track if the process name is valid or not
  Future<void> _createProcess(String processName) async {
    final box = Hive.box(processName);
    box.put('process_name', processName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Process'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF29D1B4),
      ),
      backgroundColor: Color(0xFF1C1D1C), // Set background color to #1c1d1c
      body: Center(
        // Wrap the Column with Center to horizontally center align its children
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter Process Name',
              style: TextStyle(
                color: Color(0xFF2DD3B3), // Set text color to #2dd3b3
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 350, // Adjust the width of the text field to 350
              child: TextField(
                controller:
                    processNameController, // Assign the controller to the text field
                style: TextStyle(
                  color: Color(0xFFF9F9F9),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF1C1D1C),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                        color: Color(0xFF2DD3B3),
                        width: 2), // Set border color and width
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                        color: Color(0xFF2DD3B3),
                        width: 2), // Set border color and width
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.add, // Change the icon as per your requirement
                    color: Color(0xFF2DD3B3), // Set icon color
                  ),
                ),
                cursorColor: Color(0xFFF9F9F9), // Set cursor color to #f9f9f9
                onChanged: (value) {
                  // Check if the text field has any value to enable the NEXT button
                  setState(() {
                    _isProcessNameValid = value.trim().isNotEmpty;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(
            0xFF1C1D1C), // Set bottom navigation bar container color to #1c1d1c
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.0), // Set padding to #1c1d1c
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to the main page when Cancel button is clicked
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFE73A37)), // Set button color to #e73a37
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  child: Text('CANCEL'),
                ),
              ),
            ),
            SizedBox(width: 4.0), // Add a 4-space gap between the buttons
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.0), // Set padding to #1c1d1c
                child: ElevatedButton(
                  onPressed: _isProcessNameValid
                      ? () {
                          // Navigate to VariableNamePage when Next button is clicked
                          _createProcess(processNameController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VariableNamePage(processName : processNameController.text)),
                          );
                        }
                      : () {
                          // Show the toast message when the process name is invalid and the button is clicked
                          _showInvalidProcessNameToast();
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF29D1B4)), // Set button color to #29d1b4
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

  void _showInvalidProcessNameToast() {
    Fluttertoast.showToast(
      msg: "Invalid process name",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
