import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/common.dart';
import 'decks_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    final user = Provider.of<UserModel>(context);
    context.read<CommonProvider>().getProfile(user.uid);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamProvider<List<DeckModel>?>.value(
      value: DatabaseService(uid: user.uid).decks,
      initialData: null,
      child: DecksList(),
    );
  }
}
