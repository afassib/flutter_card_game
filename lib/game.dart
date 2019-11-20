import 'package:flutter/material.dart';
import 'package:ronda_dev/card.dart';
//import 'package:ronda/card.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<RondaCard> hand;
  List<RondaCard> opponentHand;
  List<RondaCard> deck;
  List<RondaCard> arena;
  List<RondaCard> myScore;
  List<RondaCard> opponentScore;
  bool myturn;
  @override
  initState() {
    super.initState();
    myturn = true;
    deck = RondaCard.getDeck(_userClick);
    opponentHand = new List<RondaCard>();
    hand = new List<RondaCard>();
    arena = new List<RondaCard>();
    myScore = new List<RondaCard>();
    opponentScore = new List<RondaCard>();
    //
    hand.add(deck.removeLast());
    opponentHand.add(deck.removeLast());
    arena.add(deck.removeLast());
  }

  void _userClick(int a, int b) {
    setState(() {
      if(myturn) myturn = false;
      else myturn = true;
      hand.add(deck.removeLast());
      opponentHand.add(deck.removeLast());
      arena.add(deck.removeLast());
    });
  }

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Da one to beat (stupid rng btw)"),
                      Text('Score : ${opponentScore.length}')
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: AnimatedContainer(
                    decoration: (!myturn)? new BoxDecoration() : new BoxDecoration(
                      border: new Border.all(
                          color: Colors.green,
                          width: 5.0,
                          style: BorderStyle.solid),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(20.0)),
                    ),
                    duration: Duration(
                      milliseconds: 200,
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: hand.map((card) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: card,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: arena
                                .sublist(0, (arena.length ~/ 2))
                                .map((card) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: card,
                                ),
                              );
                            }).toList(),
                          )),
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: arena
                                .sublist(arena.length ~/ 2, arena.length)
                                .map((card) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: card,
                                ),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    decoration: (myturn)? new BoxDecoration() : new BoxDecoration(
                      border: new Border.all(
                          color: Colors.green,
                          width: 5.0,
                          style: BorderStyle.solid),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(20.0)),
                    ),
                    child: Row(
                      children: hand.map((card) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: card.onTapHandler,
                              child: card,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Score : ${myScore.length}'),
                      Text("Me lul")
                    ],
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
