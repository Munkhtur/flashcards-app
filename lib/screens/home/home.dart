import 'package:flashcards/models/user.dart';
import 'package:flashcards/screens/deck_view.dart';
import 'package:flashcards/screens/home/homePage.dart';
import 'package:flashcards/screens/home/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/database.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Profile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              shape: CircleBorder(),
              onPressed: () async {
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
              child: Icon(Icons.add))
          : null,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        // title: Text(
        //     style: GoogleFonts.lilitaOne(
        //         textStyle: TextStyle(
        //             color: Theme.of(context).secondaryHeaderColor,
        //             fontSize: 40)),
        //     'Deckd'),

        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/logo-white.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  style: GoogleFonts.lilitaOne(
                      textStyle: TextStyle(color: Colors.white, fontSize: 36)),
                  'Dekd'),
            )
          ],
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).secondaryHeaderColor,
        unselectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        // Set color for selected label
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
