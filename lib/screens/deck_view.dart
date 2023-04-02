import 'package:flashcards/components/flashcard.dart';
import 'package:flashcards/components/titleTextBox.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flutter/material.dart';

class DeckView extends StatefulWidget {
  final DeckModel data;
  const DeckView({required this.data, super.key});

  @override
  State<DeckView> createState() => _DeckViewState();
}

class _DeckViewState extends State<DeckView> {
  PageController _pageController = PageController(viewportFraction: 0.8);
  bool typing = false;
  String title = '';
  int currentPage = 0;
  void onTap() {
    setState(() {
      typing = !typing;
    });
  }

  @override
  void initState() {
    title = widget.data.name;
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  void setName(String name) {
    setState(() {
      title = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("fjhaklsj")),
        body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.8,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              bool active = index == currentPage;
              return MyCard(active: active);
            },
          ),
        ));
  }
}
