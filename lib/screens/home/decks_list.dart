import 'package:flashcards/components/deck.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class DecksList extends StatelessWidget {
  final List<DeckModel>? data;
  const DecksList({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    // final decks = Provider.of<List<DeckModel>?>(context);
    final decks = this.data;

    List<Widget> items = [];

    decks?.forEach((element) {
      items.add(Deck(data: element));
    });

    return Container(
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: items),
    );
  }
}
