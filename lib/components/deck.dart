import 'package:flashcards/models/deck.dart';
import 'package:flashcards/screens/deck_view.dart';
import 'package:flutter/material.dart';

class Deck extends StatelessWidget {
  final DeckModel data;
  const Deck({required this.data, super.key});

  void _onCardTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => DeckView(
                  data: data,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onCardTap(context),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: Center(child: Text(data.name)),
      ),
    );
  }
}
