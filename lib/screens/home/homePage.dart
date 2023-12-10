import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/common.dart';
import 'decks_list.dart';
import 'package:flashcards/shared/loading.dart';

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
      value: DatabaseService(uid: user.uid).decks.map<List<DeckModel>?>((data) {
        // Ensure that data is of type List<DeckModel>?
        return data;
      }),
      catchError: (context, error) {
        // Handle errors here
        print('Error: $error');
        return null; // Return a default value or handle the error appropriately
      },
      initialData: null,
      child: Consumer<List<DeckModel>?>(
        // Use Consumer to listen to the stream
        builder: (context, deckList, child) {
          if (deckList == null) {
            // Handle the case when data is still loading or an error occurred
            return Loading(); // or some other loading/error indicator
          } else {
            // Use the deckList in your DecksList widget
            return DecksList(data: deckList);
          }
        },
      ),
    );
  }
}
