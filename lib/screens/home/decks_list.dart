import 'package:dotted_border/dotted_border.dart';
import 'package:flashcards/components/deck.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/screens/deck_view.dart';
import 'package:flashcards/services/database.dart';
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
  final user = Provider.of<UserModel>(context);
    List<Widget> items = [];
   items.add(DottedBorder(
      color: Theme.of(context).colorScheme.onBackground, //c
      dashPattern: [3, 5],
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      padding: EdgeInsets.all(6),
      child: InkWell(
        onTap: () {
                         DatabaseService(uid: user.uid)
                    .updateDeckData("Untitled")
                    .then((newDeck) {
                  if (newDeck != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DeckView(
                          data: newDeck,
                        ),
                      ),
                    );
                  } else {
                    // Handle the case where newDeck is null (e.g., display an error message).
                    print(newDeck);
                  }
                });
        },
        child: Container(
          child: Center(
     
              child: Icon(Icons.add),
          ),
        ),
      ),
    ));
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
