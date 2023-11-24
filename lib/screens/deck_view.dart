import 'package:flashcards/components/addCardDialog.dart';
import 'package:flashcards/components/flashcard.dart';
import 'package:flashcards/components/titleTextBox.dart';
import 'package:flashcards/models/card.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/profile.dart';
import 'package:flashcards/providers/common.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class DeckView extends StatefulWidget {
  final DeckModel data;
  const DeckView({required this.data, super.key});

  @override
  State<DeckView> createState() => _DeckViewState();
}

class _DeckViewState extends State<DeckView> {
  final _expandableFABKey = GlobalKey<ExpandableFabState>();
  PageController _pageController = PageController(viewportFraction: 0.8);
  var cardList;
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
    cardList = DatabaseService(collectionId: widget.data.id).cards;
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
    final user = Provider.of<UserModel?>(context);
    // final profile = DatabaseService(uid: user!.uid).getProfile();
    ProfileModel profile = Provider.of<CommonProvider>(context).profile;

    void _showAddForm() {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: AddCardForm(collectionId: widget.data.id),
            );
          });
    }

    return StreamBuilder<List<FlashCardModel>>(
      stream: cardList,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        } else {
          return Consumer<CommonProvider>(builder: (context2, provider, child) {
            return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              floatingActionButtonLocation: ExpandableFab.location,
              floatingActionButton: ExpandableFab(
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                foregroundColor: Theme.of(context).accentColor,
                key: _expandableFABKey,
                type: ExpandableFabType.left,
                children: [
                  FloatingActionButton.small(
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      foregroundColor: Theme.of(context).accentColor,
                      heroTag: null,
                      child: Icon(Icons.add),
                      onPressed: () {
                        final state = _expandableFABKey.currentState;
                        _showAddForm();
                        state!.toggle();
                      }),
                  FloatingActionButton.small(
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    foregroundColor: Theme.of(context).accentColor,
                    heroTag: null,
                    child: Icon(Icons.check),
                    onPressed: () async {
                      if (await confirm(
                        context,
                        content: Text(
                          'Are you sure you want to add this card to mastered list and remove from deck?',
                        ),
                      )) {
                        final state = _expandableFABKey.currentState;
                        state!.toggle();
                        print({"prfile": profile});
                        DatabaseService(uid: user!.uid).addToMastered(
                            provider.currentId, profile.numOfMasterd);
                        return print('pressedOK');
                      }
                      return print('pressedCancel');
                    },
                  ),
                  FloatingActionButton.small(
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      foregroundColor: Theme.of(context).accentColor,
                      heroTag: null,
                      child: Icon(Icons.delete),
                      onPressed: () async {
                        if (await confirm(context,
                            content: Text(
                                "Are you sure you want to delete this card?"))) {
                          final state = _expandableFABKey.currentState;
                          DatabaseService(uid: user!.uid).deleteCard(
                              provider.currentId, profile.numOfCards);
                          state!.toggle();
                        }
                      }),
                ],
              ),
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
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
                actions: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) {
                          return Theme.of(context).primaryColor;
                        },
                      ),
                    ),
                    onPressed: () async {
                      if (await confirm(
                        context,
                        content: Text(
                          "Are you sure you want to delete this deck and all its cards?",
                        ),
                      )) {
                        DatabaseService().deleteDeck(widget.data.id);
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 24.0,
                    ),
                    label: Text(
                      'Delete deck',
                      style: TextStyle(fontSize: 15),
                    ), // <-- Text
                  ),
                ],
              ),
              body: snapshot.data!.length > 0
                  ? Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          bool active = index == currentPage;
                          Provider.of<CommonProvider>(context, listen: false)
                              .setCurrentId(snapshot.data![currentPage].id);
                          return MyCard(
                            active: active,
                            data: snapshot.data![index],
                          );
                        },
                      ),
                    )
                  : Text('nodata'),
            );
          });
        }
      },
    );
  }
}
