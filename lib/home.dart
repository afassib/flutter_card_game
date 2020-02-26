import 'package:flutter/material.dart';
import 'package:ronda_dev/levellist.dart';
import 'package:ronda_dev/rules.dart';

class Home extends StatefulWidget {
  final String message;
  final Widget message2;
  Home(this.message, this.message2);
  @override
  _HomeState createState() => _HomeState(this.message, this.message2);
}

class _HomeState extends State<Home> {
  String message;
  Widget message2;
  _HomeState(this.message, this.message2);
  _startGameAndGetResult(BuildContext context) async {
    final Widget result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LevelList()),
    );
    setState(() {
      this.message2 = result ??
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "play a first game.",
              style: TextStyle(
                color: Colors.greenAccent,
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
          );
    });
  }

  _startRules(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Rules()),
    );
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
            this.message2,
            RaisedButton(
              color: Colors.greenAccent,
              onPressed: () {
                _startGameAndGetResult(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Play",
                      style: TextStyle(
                        fontSize: 46,
                        fontFamily: "Calibri",
                      )),
                  Icon(
                    Icons.play_arrow,
                    size: 60,
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Colors.lightGreenAccent,
              onPressed: () {
                _startRules(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Game rules",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Calibri",
                      )),
                  Icon(
                    Icons.library_books,
                    size: 15,
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
