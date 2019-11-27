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
  int lastToScore;
  GlobalKey<AnimatedListState> opponentKey = GlobalKey<AnimatedListState>();
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
    lastToScore = 0;
  }

  startround() {
    if (round >= 5) {
      if (lastToScore == 0) {
        for (int i = 0; i < arena.length; i++) {
          myScore.add(arena.removeLast());
        }
      } else {
        for (int i = 0; i < arena.length; i++) {
          opponentScore.add(arena.removeLast());
        }
      }
      Navigator.pop(
          context,
          (myScore.length > opponentScore.length)
              ? "you win! (${myScore.length} - ${opponentScore.length})"
              : "you lose! (${myScore.length} - ${opponentScore.length})");
    } else {
      hand.add(deck.removeLast());
      hand.add(deck.removeLast());
      hand.add(deck.removeLast());
      hand.add(deck.removeLast());
      opponentHand.add(deck.removeLast());
      opponentHand.add(deck.removeLast());
      opponentHand.add(deck.removeLast());
      opponentHand.add(deck.removeLast());
      if (opponentKey.currentState != null) {
        opponentKey.currentState.insertItem(opponentHand.length - 4);
        opponentKey.currentState.insertItem(opponentHand.length - 3);
        opponentKey.currentState.insertItem(opponentHand.length - 2);
        opponentKey.currentState.insertItem(opponentHand.length - 1);
      }
    }
    round++;
  }

  void _userClick(RondaCard rc) {
    setState(() {
      if (myturn) {
        int index = hand.indexOf(rc);
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

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: opponentHand[index],
      ),
    );
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
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(20.0)),
                          ),
                    duration: Duration(
                      milliseconds: 200,
                    ),
                    width: double.infinity,
                    child: Center(
                      child: AnimatedList(
                        key: opponentKey,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        initialItemCount: opponentHand.length,
                        //mainAxisSize: MainAxisSize.max,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        itemBuilder: _buildItem,
                      ),
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
                                width: 1.0,
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
    int current = isPlayer ? hand[index].number : opponentHand[index].number;
    if (getSameCardIndex(current) != -1) {
      if (isPlayer) {
        score(true, hand.removeAt(index));
        score(true, arena.removeAt(getSameCardIndex(current)));
        while (getIndexofNextCard(current) != -1) {
          score(true, arena.removeAt(getIndexofNextCard(current)));
          current++;
        }
      } else {
        score(false, getLastWithAnimation(0, index));
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
        arena.add(getLastWithAnimation(0, index));
    }
  }

  int getSameCardIndex(int current) {
    int same = -1;
    for (RondaCard card in arena) {
      if (card.isSameAs(current)) {
        same = arena.indexOf(card);
      }
    }
    return same;
  }

  int getIndexofNextCard(int current) {
    int result = -1;
    for (RondaCard card in arena) {
      if (card.isNextOf(current)) result = arena.indexOf(card);
    }
    return result;
  }

  void score(isPlayer, RondaCard card) {
    if (isPlayer) {
      myScore.add(card);
      lastToScore = 0;
    } else {
      opponentScore.add(card);
      lastToScore = 1;
    }
  }

  RondaCard getLastWithAnimation(int list, int index) {
    if (list == 0) {
      opponentKey.currentState.removeItem(index, (context, animation) {
        return FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
          child: SizeTransition(
            sizeFactor:
                CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
            axisAlignment: 0.0,
            child: _buildItem(context, index, animation),
          ),
        );
      });
      return opponentHand.removeAt(index);
    } else if (list == 1) {
      return hand.removeAt(index);
    } else {
      return arena.removeAt(index);
    }
  }
}
