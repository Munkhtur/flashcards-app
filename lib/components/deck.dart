import 'package:flashcards/models/deck.dart';
import 'package:flashcards/screens/deck_view.dart';
import 'package:flashcards/services/database.dart';
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
      onLongPress: () {
        _showDeleteDialog(context);
      },
      onTap: () => _onCardTap(context),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Theme.of(context).colorScheme.onBackground),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 1,
                ),
                Text(
                  data.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                      border: Border.all(
                        color: Color.fromARGB(
                            255, 50, 49, 49), // Adjust the color as needed
                        width: 2.0, // Adjust the width as needed
                      ),
                    ),
                    child: LinearProgressIndicator(
                      color: Color.fromARGB(255, 168, 164, 164),
                      value: data.progress,
                      backgroundColor: Color.fromARGB(255, 95, 96, 96),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          title: Text(data.name),
          content: Text("Are you sure you want to delete this deck?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            TextButton(
              onPressed: () {
                DatabaseService().deleteDeck(data.id);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground)),
            ),
          ],
        );
      },
    );
  }
}
