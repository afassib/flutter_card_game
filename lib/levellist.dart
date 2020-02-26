import 'package:flutter/material.dart';
import 'game.dart';

class LevelList extends StatelessWidget {
  _startGameAndGetResult(BuildContext context) async {
    final Widget result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Game(1)),
    );
    Navigator.pop(
        context,
        result,
      );
  }
  _startGameAndGetResult2(BuildContext context) async {
    final Widget result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Game(2)),
    );
    Navigator.pop(
        context,
        result,
      );
  }
  _startGameAndGetResult3(BuildContext context) async {
    final Widget result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Game(3)),
    );
    Navigator.pop(
        context,
        result,
      );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ronda Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.greenAccent,
              onPressed: () {
                _startGameAndGetResult(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Be3loook",
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
              color: Colors.greenAccent,
              onPressed: () {
                _startGameAndGetResult2(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Mabihech!",
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
              color: Colors.greenAccent,
              onPressed: () {
                _startGameAndGetResult3(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Pchaaaakh",
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
          ],
        ),
      ),
    ),
    );
  }
}