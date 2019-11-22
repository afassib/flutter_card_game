import 'package:flutter/material.dart';
import 'package:ronda_dev/game.dart';

class Home extends StatefulWidget {
  final String message;
  final String message2;
  Home(this.message, this.message2);
  @override
  _HomeState createState() => _HomeState(this.message, this.message2);
}

class _HomeState extends State<Home> {
  String message;
  String message2;
  _HomeState(this.message, this.message2);
  _startGameAndGetResult(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Game()),
    );
    setState(() {
      this.message2 = result??"play a first game.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              this.message ?? "Click start to play!",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              this.message2,
              style: TextStyle(
                color: Colors.green[400],
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              onPressed: () {
                _startGameAndGetResult(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Play",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Calibri",
                      )),
                  Icon(
                    Icons.play_arrow,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
