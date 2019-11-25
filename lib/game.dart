import 'dart:async';

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
  String gameid;
  int myid;
  int round;
  //_GameState(this.gameid);
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
    deck.shuffle();
    round = 1;
    startround();
  }

  startround() {
    if (round >= 5) {
      Navigator.pop(context, myScore.length > opponentScore.length ? "You win!!!!" : "you lose!");
    } else {
      hand.add(deck.removeLast());
      hand.add(deck.removeLast());
      hand.add(deck.removeLast());
      hand.add(deck.removeLast());
      opponentHand.add(deck.removeLast());
      opponentHand.add(deck.removeLast());
      opponentHand.add(deck.removeLast());
      opponentHand.add(deck.removeLast());
    }
    round++;
  }

  void _userClick(RondaCard rc) {
    setState(() {
      if (myturn) {
        int index = hand.indexOf(rc);
        print("_userClick : Selected index is $index");
        play(true, index);
        myturn = false;
        if (opponentHand.isNotEmpty) {
          Timer(Duration(seconds: 1), () {
            setState(() {
              play(false, 0);
              myturn = true;
              if (opponentHand.isEmpty) {
                startround();
              }
            });
          });
        }
        //myturn = false;
      }
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
                    decoration: (myturn)
                        ? new BoxDecoration()
                        : new BoxDecoration(
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
                      children: opponentHand.map((card) {
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
                    decoration: (!myturn)
                        ? new BoxDecoration()
                        : new BoxDecoration(
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
                              onTap: card.customOnTap(),
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

  void play(bool isPlayer, int index) {
    int current = isPlayer? hand[index].number : opponentHand[index].number;
    print("Play: current card is ${current+1}");
    print("Play: getSameCardIndex(current) : ${getSameCardIndex(current)}");
    if (getSameCardIndex(current) != -1) {
      if (isPlayer) {
        score(true, hand.removeAt(index));
        score(true, arena.removeAt(getSameCardIndex(current)));
        while (getIndexofNextCard(current) != -1) {
          score(true, arena.removeAt(getIndexofNextCard(current)));
          current++;
        }
      } else {
        score(false, opponentHand.removeAt(index));
        score(false, arena.removeAt(getSameCardIndex(current)));
        while (getIndexofNextCard(current) != -1) {
          score(false, arena.removeAt(getIndexofNextCard(current)));
          current++;
        }
      }
    } else {
      if (isPlayer)
        arena.add(hand.removeAt(index));
      else
        arena.add(opponentHand.removeAt(index));
    }
  }

  int getSameCardIndex(int current) {
    int same = -1;
    for (RondaCard card in arena) {
      if (card.isSameAs(current)) {
        same = arena.indexOf(card);
        print("Card ${card.number} is same as $current !");
      }
    }
    return same;
  }

  int getIndexofNextCard(int current) {
    int result = -1;
    for (RondaCard card in arena) {
      if (card.isNextOf(current)){
        result = arena.indexOf(card);
        print("Card ${card.number} is next of $current !");
      }
    }
    return result;
  }

  void score(isPlayer, RondaCard card) {
    if (isPlayer) {
      myScore.add(card);
    } else {
      opponentScore.add(card);
    }
  }
}
