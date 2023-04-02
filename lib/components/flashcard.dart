import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.VERTICAL,
      front: Container(
        decoration: BoxDecoration(
          color: Color(0xFF006666),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        alignment: Alignment.center,
        width: 300,
        height: 300,
        child: Text("Front"),
      ),
      // back of the card
      back: Container(
        alignment: Alignment.center,
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Color(0xFF006666),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Text("Back"),
      ),
    );
  }
}
