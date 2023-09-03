import 'package:flutter/material.dart';
import 'package:sop_time_tracker/createProcess/processName.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SOP Tracker',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFF2BD2B4)),
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
        title: Text('SOP Tracker'),
        backgroundColor: Color(0xFF2BD2B4),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1C1D1C), // Set background color
        ),
        child: Center(
          child: MenuButtons(),
        ),
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
          height: 50,
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProcessNamePage(),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2BD2B4)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Round the button corners
                ),
              ),
            ),
            child: Text('Create Process'),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              print('Existing Process button pressed.');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2BD2B4)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Round the button corners
                ),
              ),
            ),
            child: Text('Existing Process'),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              print('Import Process File button pressed.');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2BD2B4)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Round the button corners
                ),
              ),
            ),
            child: Text('Import Process File'),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              print('Export Process File button pressed.');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2BD2B4)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Round the button corners
                ),
              ),
            ),
            child: Text('Export Process File'),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              print('Export Recorded File button pressed.');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2BD2B4)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Round the button corners
                ),
              ),
            ),
            child: Text('Export Recorded File'),
          ),
        ),
      ],
    );
  }
}

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
