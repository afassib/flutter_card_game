import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final int type;
  final int number; 
  Card(this.type, this.number);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage(""),
      )
    );
  }
  List<Card> getDeck()
  {
    return null;
  }
}