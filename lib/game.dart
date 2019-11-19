import 'package:flutter/material.dart';
import 'package:ronda_dev/card.dart';
//import 'package:ronda/card.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    duration: Duration(
                      milliseconds: 1000,
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RondaCard(3, 9),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RondaCard(0, 9),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RondaCard(3, 9),
                          ),
                        ),
                      ],
                    ),
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
