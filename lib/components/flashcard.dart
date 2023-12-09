import 'package:flashcards/models/card.dart';
import 'package:flashcards/providers/common.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCard extends StatefulWidget {
  final bool active;
  final FlashCardModel data;
  const MyCard({super.key, required this.active, required this.data});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  String currentId = "";
  void setCurrentId(String id) {
    Provider.of<CommonProvider>(context, listen: false).setCurrentId(id);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CommonProvider>(context).currentId = widget.data.id;
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      // alignment: Alignment.centerRight,
      width: 0.8 * deviceWidth, // 90% of the device width
      height: 0.5 * deviceHeight, // 6
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInQuint,
      // margin: EdgeInsets.only(top: top, bottom: bottom, right: 30),
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //         color: Color.fromARGB(221, 5, 5, 54),
      //         blurRadius: 10,
      //         offset: Offset(2, 5))
      //   ],
      // ),

      child: FlipCard(
        direction: FlipDirection.VERTICAL,

        front: PhysicalModel(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.transparent,
          elevation: 8.0, // Set your desired elevation value
          shadowColor: Colors.black,
          child: Container(
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            alignment: Alignment.center,
            width: 400,
            height: 400,
            child: Text(
              widget.data.question,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
        // back of the card
        back: PhysicalModel(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.transparent,
          elevation: 8.0, // Set your desired elevation value
          shadowColor: Colors.black,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Definition:',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(widget.data.answer),
                      ],
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Exampe use:"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(widget.data.description),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
