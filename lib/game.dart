import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ronda_dev/card.dart';
import 'package:audioplayers/audio_cache.dart';

import 'ai.dart';

class PointGenerator {
  int lastNumber;
  int lastPlayer;
  int point;
  PointGenerator() {
    lastPlayer = -1;
    lastPlayer = -1;
    point = 0;
  }
  bool scorePoint(int player, int number) {
    return point == 0
        ? false
        : point == 1 && player != lastPlayer && number == lastNumber
            ? true
            : false;
  }

  int getLastCardByPlayer() {
    return lastPlayer == 1 && point == 1
        ? lastNumber > -1 && lastNumber < 10 ? lastNumber : -1
        : -1;
  }

  void setV(int number, player, p) {
    lastNumber = number;
    lastPlayer = player;
    point = p;
  }
}

class Game extends StatefulWidget {
  final int level;
  Game(this.level);
  @override
  _GameState createState() => _GameState(this.level);
}

class _GameState extends State<Game> {
  _GameState(this.level);
  final int level;
  static AudioCache player = new AudioCache();
  static const confirmation = "sounds/confirmation.wav";
  static const gameover = "sounds/gameover.wav";
  static const money = "sounds/money.wav";
  static const wingame = "sounds/wingame.wav";
  static const click = "sounds/click.wav";
  List<RondaCard> hand;
  List<RondaCard> opponentHand;
  List<RondaCard> deck;
  List<RondaCard> arena1;
  List<RondaCard> arena2;
  List<RondaCard> myScore;
  List<RondaCard> opponentScore;
  int myScore2 = 0;
  int opponentScore2 = 0;
  PointGenerator pointGenerator = new PointGenerator();
  bool myturn;
  String gameid;
  int myid;
  int round;
  int lastToScore;
  int lastcardplayedbyme = -1;
  GlobalKey<AnimatedListState> opponentKey = GlobalKey();
  GlobalKey<AnimatedListState> myKey = GlobalKey();
  GlobalKey<AnimatedListState> arena1Key = GlobalKey();
  GlobalKey<AnimatedListState> arena2Key = GlobalKey();
  //_GameState(this.gameid);
  @override
  initState() {
    super.initState();
    myturn = true;
    deck = RondaCard.getDeck(_userClick);
    print(deck.length);
    opponentHand = new List<RondaCard>();
    hand = new List<RondaCard>();
    arena1 = new List<RondaCard>();
    arena2 = new List<RondaCard>();
    myScore = new List<RondaCard>();
    opponentScore = new List<RondaCard>();
    deck.shuffle();
    round = 1;
    startround();
    lastToScore = 0;
  }

  startround() {
    print("(${myScore.length} - ${opponentScore.length})");
    if (round > 5) {
      if (lastToScore == 0) {
        while (arena1.isNotEmpty) {
          myScore.add(getLastWithAnimation(1, 0)); //arena1.length - 1));
        }
        while (arena2.isNotEmpty) {
          myScore.add(getLastWithAnimation(2, 0)); //arena2.length - 1));
        }
      } else {
        while (arena1.isNotEmpty) {
          opponentScore.add(getLastWithAnimation(1, 0)); //arena1.length - 1));
        }
        while (arena2.isNotEmpty) {
          opponentScore.add(getLastWithAnimation(2, 0)); //arena2.length - 1));
        }
      }
      print(myScore);
      print(opponentScore);
      print(arena1);
      print(arena2);
      myScore.length + myScore2 > opponentScore.length + opponentScore2
          ? player.play(wingame)
          : player.play(gameover);
      Navigator.pop(
        context,
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            (myScore.length + myScore2 > opponentScore.length + opponentScore2)
                ? "you win! => ${myScore.length + myScore2} (${myScore.length}/$myScore2) VS ${opponentScore.length + opponentScore2} (${opponentScore.length}/$opponentScore2)"
                : "you lose! => ${myScore.length + myScore2} (${myScore.length}/$myScore2) VS ${opponentScore.length + opponentScore2} (${opponentScore.length}/$opponentScore2)",
            style: TextStyle(
              color: (myScore.length + myScore2 >
                      opponentScore.length + opponentScore2)
                  ? Colors.greenAccent
                  : Colors.redAccent,
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
          ),
        ),
      );
    } else {
      hand.add(deck.removeLast());
      hand.add(deck.removeLast());
      hand.add(deck.removeLast());
      hand.add(deck.removeLast());
      if (myKey.currentState != null) {
        myKey.currentState.insertItem(hand.length - 4);
        myKey.currentState.insertItem(hand.length - 3);
        myKey.currentState.insertItem(hand.length - 2);
        myKey.currentState.insertItem(hand.length - 1);
      }
      opponentHand.add(deck.removeLast().swapSide());
      opponentHand.add(deck.removeLast().swapSide());
      opponentHand.add(deck.removeLast().swapSide());
      opponentHand.add(deck.removeLast().swapSide());
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
              play(
                  false,
                  level == 3
                      ? AI.level3Play(opponentHand, arena1 + arena2, pointGenerator.getLastCardByPlayer())
                      : level == 2
                          ? AI.level2Play(opponentHand, arena1 + arena2)
                          : AI.level1Play(opponentHand, arena1 + arena2));
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

  Widget _buildItem21(
      BuildContext context, int index, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: arena1[index],
      ),
    );
  }

  Widget _buildItem22(
      BuildContext context, int index, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: arena2[index],
      ),
    );
  }

  Widget _buildItem3(
      BuildContext context, int index, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: GestureDetector(
        onTap: hand[index].customOnTap(),
        child: hand[index],
      ),
    );
  }

  Widget _buildItem4(
      BuildContext context, int index, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Image(
          image: AssetImage('assets/cards/back.gif'),
        ),
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
                      Text('Score : ${opponentScore.length + opponentScore2}')
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: AnimatedContainer(
                    decoration: (myturn)
                        ? new BoxDecoration(
                            border: new Border.all(
                                color: Colors.greenAccent,
                                width: 0.5,
                                style: BorderStyle.solid),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(20.0)),
                          )
                        : new BoxDecoration(
                            border: new Border.all(
                                color: Colors.green,
                                width: 3.0,
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
                        child: Center(
                          child: AnimatedList(
                            key: arena1Key,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            initialItemCount: arena1.length,
                            //mainAxisSize: MainAxisSize.max,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            itemBuilder: _buildItem21,
                          ),
                        ),
                        /*Row(
                          children:
                              arena.sublist(0, (arena.length ~/ 2)).map((card) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: card,
                              ),
                            );
                          }).toList(),
                        ),*/
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: AnimatedList(
                            key: arena2Key,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            initialItemCount: arena2.length,
                            //mainAxisSize: MainAxisSize.max,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            itemBuilder: _buildItem22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    decoration: (!myturn)
                        ? new BoxDecoration(
                            border: new Border.all(
                                color: Colors.greenAccent,
                                width: 0.5,
                                style: BorderStyle.solid),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(20.0)),
                          )
                        : new BoxDecoration(
                            border: new Border.all(
                                color: Colors.green,
                                width: 3.0,
                                style: BorderStyle.solid),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(20.0)),
                          ),
                    width: double.infinity,
                    child: Center(
                      child: AnimatedList(
                        key: myKey,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        initialItemCount: hand.length,
                        itemBuilder: _buildItem3,
                      ),
                    ), /*Row(
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
                    ),*/
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Score : ${myScore.length + myScore2}'),
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
    player.play(click);
    int current = isPlayer ? hand[index].number : opponentHand[index].number;
    List<int> getit = getSameCardIndex(current);
    print(getit);
    if (getit[1] != -1) {
      if (isPlayer) {
        if (pointGenerator.scorePoint(1, current)) {
          player.play(money);
          myScore2++;
          pointGenerator.setV(null, null, 0);
        } else
          player.play(confirmation);
        score(true, getLastWithAnimation(3, index));
        score(true, getLastWithAnimation(getit[0], getit[1]));
        while (getIndexofNextCard(current)[1] != -1) {
          score(
              true,
              getLastWithAnimation(getIndexofNextCard(current)[0],
                  getIndexofNextCard(current)[1]));
          current++;
        }
      } else {
        if (pointGenerator.scorePoint(0, current)) {
          player.play(money);
          opponentScore2++;
          pointGenerator.setV(null, null, 0);
        } else
          player.play(confirmation);
        score(false, getLastWithAnimation(0, index));
        score(false, getLastWithAnimation(getit[0], getit[1]));
        while (getIndexofNextCard(current)[1] != -1) {
          score(
              false,
              getLastWithAnimation(getIndexofNextCard(current)[0],
                  getIndexofNextCard(current)[1]));
          current++;
        }
      }
    } else {
      if (isPlayer) {
        pointGenerator.setV(current, 1, 1);
        if (arena2.length >= 4) {
          arena1.add(getLastWithAnimation(3, index));
          if (arena1Key.currentState != null)
            arena1Key.currentState.insertItem(arena1.length - 1);
        } else {
          arena2.add(getLastWithAnimation(3, index));
          if (arena2Key.currentState != null)
            arena2Key.currentState.insertItem(arena2.length - 1);
        }
      } else {
        pointGenerator.setV(current, 0, 1);
        if (arena1.length >= 4) {
          arena2.add(getLastWithAnimation(0, index));
          if (arena2Key.currentState != null)
            arena2Key.currentState.insertItem(arena2.length - 1);
        } else {
          arena1.add(getLastWithAnimation(0, index));
          if (arena1Key.currentState != null)
            arena1Key.currentState.insertItem(arena1.length - 1);
        }
      }
    }
  }

  List<int> getSameCardIndex(int current) {
    int same = -1;
    for (RondaCard card in arena1) {
      if (card.isSameAs(current)) {
        same = arena1.indexOf(card);
      }
    }
    if (same != -1)
      return [1, same];
    else {
      for (RondaCard card in arena2) {
        if (card.isSameAs(current)) {
          same = arena2.indexOf(card);
        }
      }
    }
    return [2, same];
  }

  List<int> getIndexofNextCard(int current) {
    int result = -1;
    for (RondaCard card in arena1) {
      if (card.isNextOf(current)) result = arena1.indexOf(card);
    }
    if (result != -1)
      return [1, result];
    else {
      for (RondaCard card in arena2) {
        if (card.isNextOf(current)) result = arena2.indexOf(card);
      }
    }
    return [2, result];
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
      if (opponentKey.currentState != null)
        opponentKey.currentState.removeItem(index, (context, animation) {
          return FadeTransition(
            opacity:
                CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
            child: SizeTransition(
              sizeFactor:
                  CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
              axisAlignment: 0.0,
              child: _buildItem4(context, index, animation),
            ),
          );
        });
      return opponentHand.removeAt(index).swapSide();
    } else if (list == 3) {
      if (myKey.currentState != null)
        myKey.currentState.removeItem(index, (context, animation) {
          return FadeTransition(
            opacity:
                CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
            child: SizeTransition(
              sizeFactor:
                  CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
              axisAlignment: 0.0,
              child: _buildItem4(context, index, animation),
            ),
          );
        });
      return hand.removeAt(index);
    } else if (list == 1) {
      if (arena1Key.currentState != null)
        arena1Key.currentState.removeItem(index, (context, animation) {
          return FadeTransition(
            opacity:
                CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
            child: SizeTransition(
              sizeFactor:
                  CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
              axisAlignment: 0.0,
              child: _buildItem4(context, index, animation),
            ),
          );
        });
      return arena1.removeAt(index);
    } else {
      if (arena2Key.currentState != null)
        arena2Key.currentState.removeItem(index, (context, animation) {
          return FadeTransition(
            opacity:
                CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
            child: SizeTransition(
              sizeFactor:
                  CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
              axisAlignment: 0.0,
              child: _buildItem4(context, index, animation),
            ),
          );
        });
      return arena2.removeAt(index);
    }
  }
}
