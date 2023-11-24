import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flashcards/components/deck.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/shared/loading.dart';
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
    final decks = Provider.of<List<DeckModel>?>(context);
    final user = Provider.of<UserModel>(context);

    List<Widget> items = [];
    items.add(DottedBorder(
      color: Theme.of(context).primaryColor, //c
      dashPattern: [3, 5],
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      padding: EdgeInsets.all(6),
      child: Container(
        child: Center(
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              var data = await DatabaseService(uid: user.uid)
                  .updateDeckData('untitled');
            },
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
