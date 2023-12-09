import 'package:flashcards/screens/home/homePage.dart';
import 'package:flashcards/screens/home/profile.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(

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
    
        showSelectedLabels: false,
showUnselectedLabels: false,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).secondaryHeaderColor,
        unselectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person,     size: 30,), label: 'Profile'),
        ],
        // Set color for selected label
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
