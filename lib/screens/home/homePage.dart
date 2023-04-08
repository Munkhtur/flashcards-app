import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/components/deck.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flashcards/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/profile.dart';
import '../../providers/common.dart';
import 'decks_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    DatabaseService(uid: user.uid).profile;
    // print({"proilehomepafe": profile});
    print({"userhomepage": user});

    // print(items);
    // return Container(
    //     child: GridView.count(
    //         primary: false,
    //         padding: const EdgeInsets.all(20),
    //         crossAxisSpacing: 10,
    //         mainAxisSpacing: 10,
    //         crossAxisCount: 2,
    //         children: items));

    return StreamProvider<List<DeckModel>?>.value(
      value: DatabaseService(uid: user.uid).decks,
      initialData: null,
      child: DecksList(),
    );
  }
}
