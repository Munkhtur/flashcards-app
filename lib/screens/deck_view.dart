import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flashcards/components/addCardDialog.dart';
import 'package:flashcards/components/animatedTextSwitcher.dart';
import 'package:flashcards/components/flashcard.dart';
import 'package:flashcards/components/titleTextBox.dart';
import 'package:flashcards/models/card.dart';
import 'package:flashcards/models/deck.dart';
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

class _DeckViewState extends State<DeckView> with TickerProviderStateMixin {
  final _expandableFABKey = GlobalKey<ExpandableFabState>();
  PageController _pageController = PageController(viewportFraction: 0.8);
  final AppinioSwiperController controller = AppinioSwiperController();
  late AnimationController _animController;
  var cardList;
  bool typing = false;
  String title = '';
  int currentPage = 0;
  int score = 0;
  bool isEnd = false;
  Color _scoreColor = Color.fromARGB(255, 97, 96, 96);
  void onTap(bool istypeing) {
    setState(() {
      typing = istypeing;
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

    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            // Animation is complete, return to regular color
            _scoreColor = Color.fromARGB(255, 97, 96, 96); 
            
            // score = score + 1;
          });
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void setName(String name) {
    setState(() {
      title = name;
    });
  }

  void _changeText(int i) {
    setState(() {
      score += 1;
      _scoreColor = Colors.red; // Change to the desired color
    });

    _animController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    // final profile = DatabaseService(uid: user!.uid).getProfile();
    // ProfileModel profile = Provider.of<CommonProvider>(context).profile;

    void _showAddForm() {
      showModalBottomSheet(
          isDismissible: true,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: AddCardForm(collectionId: widget.data.id),
                ),
              ),
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
            return GestureDetector(
              onTap: () {
                // Hide the keyboard when tapped outside the TextField
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                // resizeToAvoidBottomInset: false,
                // backgroundColor: Theme.of(context).colorScheme.background,

                floatingActionButtonLocation: ExpandableFab.location,
                floatingActionButton: ExpandableFab(
                  openButtonBuilder: RotateFloatingActionButtonBuilder(
                    child: const Icon(Icons.menu),
                    fabSize: ExpandableFabSize.regular,
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    shape: const CircleBorder(),
                  ),
                  closeButtonBuilder: DefaultFloatingActionButtonBuilder(
                    child: const Icon(Icons.close),
                    fabSize: ExpandableFabSize.small,
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    shape: const CircleBorder(),
                  ),
                  key: _expandableFABKey,
                  type: ExpandableFabType.side,
                  children: [
                    FloatingActionButton.small(
                        backgroundColor: Theme.of(context).secondaryHeaderColor,
                        // foregroundColor: Theme.of(context).accentColor,
                        shape: CircleBorder(),
                        heroTag: null,
                        child: Icon(Icons.add),
                        onPressed: () {
                          final state = _expandableFABKey.currentState;
                          _showAddForm();
                          state!.toggle();
                        }),
                    if (snapshot.data!.length > 0)
                      FloatingActionButton.small(
                        backgroundColor: Theme.of(context).secondaryHeaderColor,
                        shape: CircleBorder(),

                        // foregroundColor: Theme.of(context).accentColor,
                        heroTag: null,
                        child: Icon(Icons.check),
                        onPressed: () async {
                          if (await confirm(
                            context,
                            content: Text(
                              'Are you sure you want to add this card to mastered list and remove from deck?',
                            ),
                            textOK: Text(
                              'Ok',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            textCancel: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                          )) {
                            final state = _expandableFABKey.currentState;
                            state!.toggle();
                            DatabaseService(uid: user!.uid).addToMastered(
                                provider.currentId,
                                provider.profile.numOfMasterd);
                            return print('pressedOK');
                          }
                          return print('pressedCancel');
                        },
                      ),
                    if (snapshot.data!.length > 0)
                      FloatingActionButton.small(
                          backgroundColor:
                              Theme.of(context).secondaryHeaderColor,
                          shape: CircleBorder(),

                          // foregroundColor: Theme.of(context).primaryColor,
                          heroTag: null,
                          child: Icon(Icons.delete),
                          onPressed: () async {
                            if (await confirm(
                              context,
                              content: Text(
                                  "Are you sure you want to delete this card?"),
                              textOK: Text(
                                'Ok',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              textCancel: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                            )) {
                              final state = _expandableFABKey.currentState;
                              DatabaseService(uid: user!.uid).deleteCard(
                                  provider.currentId,
                                  provider.profile.numOfCards);
                              if (snapshot.data!.length == 1) {
                                reinitializeController();
                              }
                              state!.toggle();
                            }
                          }),
                  ],
                ),
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  title: typing
                      ? TitleBox(
                          onTap: onTap,
                          oldTitle: widget.data.name,
                          id: widget.data.id,
                          setname: setName,
                        )
                      : InkWell(
                          onTap: () => onTap(true),
                          child: Text(
                              style: TextStyle(color: Colors.white), title),
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
                          textOK: Text(
                            'Ok',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          textCancel: Text(
                            'Cancel',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                        )) {
                          DatabaseService().deleteDeck(widget.data.id);
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        color: Colors.white,
                        Icons.delete,
                        size: 24.0,
                      ),
                      label: Text(
                        '',
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor),
                      ), // <-- Text
                    ),
                  ],
                ),
                body: snapshot.data!.length > 0
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AnimatedTextSwitcher(
                                      child: Text(
                                        score.toString(),
                                        key: ValueKey<String>(score.toString()),
                                        style: TextStyle(
                                            color: _scoreColor, fontSize: 20),
                                      ),
                                      controller: _animController,
                                    ),
                                    Text(
                                      " / ",
                                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 97, 96, 96)),
                                    ),
                                    Text(
                                      snapshot.data!.length.toString(),
                                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 97, 96, 96)),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 50,
                            ),
                            Stack(
                                // width: double.infinity,
                                alignment: Alignment.center,
                                children: [
                                  if (isEnd)
                                    Container(
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // Center vertically
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Score " +
                                                  ((score /
                                                              snapshot.data!
                                                                  .length) *
                                                          100)
                                                      .ceil()
                                                      .toString() +
                                                  "%",
                                              style: TextStyle(fontSize: 35),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            IconButton(
                                              iconSize: 35,
                                              icon: const Icon(Icons.refresh),
                                              onPressed: () async {
                                                print(snapshot.data!.length);
                                                setState(() {
                                                  score = 0;
                                                  isEnd = false;
                                                });
                                                for (int i = 0;
                                                    i < snapshot.data!.length;
                                                    i++) {
                                                  const Duration
                                                      timeoutDuration =
                                                      Duration(
                                                          milliseconds: 100);

                                                  // Using Future.delayed to introduce a timeout
                                                  await Future.delayed(
                                                      timeoutDuration, () {
                                                    // This block will be executed after the specified duration
                                                    controller.unswipe();
                                                  });
                                                  print("unswipte");
                                                  print({"i": i});
                                                }
                                              },
                                            ),
                                          ]),
                                    ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .5,
                                    width:
                                        MediaQuery.of(context).size.width * .8,
                                    child: AppinioSwiper(
                                      controller: controller,
                                      allowUnSwipe: true,
                                      allowUnlimitedUnSwipe: true,
                                      swipeOptions: SwipeOptions.only(
                                          left: true, right: true),
                                      onEnd: () async {
                                        setState(() {
                                          isEnd = true;
                                        });
                                        DatabaseService(uid: user!.uid)
                                            .updateDeckName(
                                                id: widget.data.id,
                                                progress: (score /
                                                    snapshot.data!.length));
                                      },
                                      onSwipeEnd: (index, toIndex, swipe) {
                                        if (swipe.direction ==
                                                AxisDirection.right &&
                                            swipe.runtimeType == Swipe) {
                                          _changeText(toIndex);
                                        }
                                      },
                                      cardBuilder:
                                          (BuildContext context, int index) {
                                        bool active = index == currentPage;
                                        return MyCard(
                                          key: UniqueKey(),
                                          active: active,
                                          data: snapshot.data![index],
                                        );
                                      },
                                      cardCount: snapshot.data!.length,
                                      backgroundCardCount: 2,
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      )
                    : Center(
                    
                      child: 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ Icon(Icons.add_circle_outline,size: 80,color: Theme.of(context).colorScheme.onBackground,),
                      SizedBox(height: 30,),
                    Text(" Add cards to continue", style: TextStyle(color: Theme.of(context).colorScheme.onBackground,),)
                    ],)
                    ),
              ),
            );
          });
        }
      },
    );
  }

  void reinitializeController() {
    // if (_animController != null) {
    //   // Dispose the existing controller
    //   _animController.dispose();
    // }

    // Create a new controller
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            // Animation is complete, return to regular color
            _scoreColor = Color.fromARGB(255, 97, 96, 96); // Change to the regular color
            // score = score + 1;
          });
        }
      });

    // Optionally, start the animation immediately after reinitializing
    _animController.forward();
  }
}
