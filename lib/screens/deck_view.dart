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
  PageController _pageController = PageController();
  bool typing = false;
  String title = '';
  void onTap() {
    setState(() {
      typing = !typing;
    });
  }

  @override
  void initState() {
    title = widget.data.name;
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
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: typing
              ? titleBox(
                  onTap: onTap,
                  oldTitle: widget.data.name,
                  id: widget.data.id,
                  setname: setName,
                )
              : InkWell(
                  onTap: onTap,
                  child: Text(title),
                ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Row(
              children: [
                MyCard(),
                MyCard(),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
