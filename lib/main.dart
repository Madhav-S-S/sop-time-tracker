import 'package:flutter/material.dart';
import 'createProcess/processName.dart';

void main() {
  runApp(MaterialApp(
    home: MainPage(),
  ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the CreateProcessPage when the button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProcessNamePage()),
            );
          },
          child: Text('Go to Create Process'),
        ),
      ),
    );
  }
}
