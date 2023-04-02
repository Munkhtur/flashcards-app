import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/components/deck.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/database.dart';

class DecksList extends StatelessWidget {
  const DecksList({super.key});

  @override
  Widget build(BuildContext context) {
    final decks = Provider.of<List<DeckModel>>(context);
    final user = Provider.of<UserModel>(context);

    List<Widget> items = [];
    decks.forEach((element) {
      items.add(Deck(data: element));
    });

    items.add(Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            await DatabaseService(uid: user.uid).updateDeckData('untitled');
          },
          child: const Text('Enabled'),
        ),
      ),
    ));
    return Container(
        child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: items));
  }
}
