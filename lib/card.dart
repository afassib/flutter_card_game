import 'package:flutter/material.dart';

class RondaCard extends StatefulWidget {
  //static _RondaCardState of(BuildContext context) => context.findAncestorStateOfType();
  final int type;
  final int number;
  final onTapHandler;
  final int side;
  RondaCard(this.type, this.number, this.onTapHandler, this.side);
  @override
  _RondaCardState createState() => _RondaCardState(this.side);

  Function customOnTap() {
    return () => onTapHandler(this);
  }

  static List<RondaCard> getDeck(Function onTap) {
    List<RondaCard> deck = new List<RondaCard>();
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 10; j++) {
        deck.add(RondaCard(i, j, onTap, 1));
      }
    }
    return deck;
  }

  bool isSameAs(int rc) {
    return rc == this.number;
  }

  bool isNextOf(int rc) {
    return rc + 1 == this.number;
  }

  RondaCard swapSide()
  {
    return side==0 ? RondaCard(this.type, this.number, this.onTapHandler, 1) : RondaCard(this.type, this.number, this.onTapHandler, 1);
  }
}

class _RondaCardState extends State<RondaCard> {
  int side;
  _RondaCardState(this.side);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: side==1 ? AssetImage('assets/cards/${widget.type}${widget.number}.gif') : AssetImage('assets/cards/back.gif'),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}