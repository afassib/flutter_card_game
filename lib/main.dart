import 'package:flutter/material.dart';
import 'package:ronda_dev/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ronda Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Home("Ronda Flutter v1.0", Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Play a first game :)",
            style: TextStyle(
              color: Colors.blueAccent,
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
          ),
        )),
      ),
    );
  }
}
