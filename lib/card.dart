import 'package:flutter/material.dart';

class RondaCard extends StatelessWidget {
  final int type;
  final int number;
  final onTapHandler;
  RondaCard(this.type, this.number, this.onTapHandler);
  @override
  Widget build(BuildContext context) {
    return Image(
            image: AssetImage('assets/cards/$type$number.gif'),
    );
  }

  static List<RondaCard> getDeck(Function onTap) {
    List<RondaCard> deck = new List<RondaCard>();
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 10; j++) {
        deck.add(RondaCard(i, j, onTap));
      }
    }
    return deck;
  }

  Function customOnTap()
  {
    return () => onTapHandler(this);
  }

  bool isSameAs(int rc)
  {
    return rc == this.number;
  }

  bool isNextOf(int rc)
  {
    return rc+1 == this.number;
  }
}
