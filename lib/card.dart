import 'package:flutter/material.dart';

class RondaCard extends StatelessWidget {
  final int type;
  final int number; 
  RondaCard(this.type, this.number);
  @override
  Widget build(BuildContext context) {
    return Image(
        image: AssetImage('assets/cards/$type$number.gif'),
      );
  }
  List<Card> getDeck()
  {
    return null;
  }
}