import 'package:flutter/material.dart';
import 'package:sop_time_tracker/createProcess/processName.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SOP Tracker', // Change app name to "SOP Tracker"
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFF2BD2B4)), // Set primary color
        scaffoldBackgroundColor: Colors.black, // Set background color
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOP Tracker'), // Change app bar title to "SOP Tracker"
        backgroundColor: Color(0xFF2BD2B4), // Set app bar color
      ),
      body: Center(
        child: MenuButtons(),
      ),
    );
  }
}

class MenuButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 200, // Set the desired fixed width for the buttons
          child: ElevatedButton(
            onPressed: () {
              // TODO: Add functionality for "Create Process" button
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProcessNamePage(),
                ),
              );
            },
            child: Text('Create Process'),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: 200, // Set the desired fixed width for the buttons
          child: ElevatedButton(
            onPressed: () {
              // TODO: Add functionality for "Existing Process" button
              print('Existing Process button pressed.');
            },
            child: Text('Existing Process'),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: 200, // Set the desired fixed width for the buttons
          child: ElevatedButton(
            onPressed: () {
              // TODO: Add functionality for "Import Process File" button
              print('Import Process File button pressed.');
            },
            child: Text('Import Process File'),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: 200, // Set the desired fixed width for the buttons
          child: ElevatedButton(
            onPressed: () {
              // TODO: Add functionality for "Export Process File" button
              print('Export Process File button pressed.');
            },
            child: Text('Export Process File'),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: 200, // Set the desired fixed width for the buttons
          child: ElevatedButton(
            onPressed: () {
              // TODO: Add functionality for "Export Recorded File" button
              print('Export Recorded File button pressed.');
            },
            child: Text('Export Recorded File'),
          ),
        ),
      ],
    );
  }
}

// Helper function to create a MaterialColor from a Color
MaterialColor createMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });

  return MaterialColor(color.value, swatch);
}
