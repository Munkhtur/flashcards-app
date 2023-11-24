import 'package:flashcards/models/deck.dart';
import 'package:flashcards/screens/deck_view.dart';
import 'package:flutter/material.dart';

import '../shared/tooltipshape.dart';

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
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            data.name,
            style: Theme.of(context).primaryTextTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
