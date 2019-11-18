import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Ronda Game",
          ),
        ),
        body: Center(
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.green[200],
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            color: Colors.red[200],
                            child: FlatButton(
                              child: Text("Tap"),
                              onPressed: (){
                                print("Button pressed");
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            color: Colors.red[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.green[200],
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}