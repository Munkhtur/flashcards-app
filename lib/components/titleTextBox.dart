import 'package:flashcards/services/database.dart';
import 'package:flutter/material.dart';

class TitleBox extends StatefulWidget {
  final Function onTap;
  final Function setname;
  final String oldTitle;
  final String id;
  TitleBox({
    super.key,
    required this.onTap,
    required this.oldTitle,
    required this.id,
    required this.setname,
  });

  @override
  State<TitleBox> createState() => TitleBoxState();
}

class TitleBoxState extends State<TitleBox> {
  TextEditingController _controller = new TextEditingController();
  FocusNode myfocus = FocusNode();
  String title = "";

  @override
  void initState() {
    title = widget.oldTitle;
    _controller.text = title;
    Future.delayed(Duration(seconds: 0), () {
      myfocus.requestFocus(); //auto focus on second text field.
    });
    myfocus.addListener(() {
      if (myfocus.hasFocus) {
      } else {
        widget.onTap(false);
        if (widget.oldTitle != title && title != "") {
          widget.setname(title);
          DatabaseService().updateDeckName(name: title, id: widget.id);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Color.fromARGB(0, 15, 94, 205),
      child: TextField(
        maxLength: 20,

        onChanged: (value) {
          setState(() {
            title = value;
          });
        },
        style: TextStyle(color: Theme.of(context).primaryColor),
        controller: _controller,
        focusNode: myfocus,
        // autofocus: true,
        cursorColor: const Color.fromARGB(255, 237, 237, 237),
        decoration: InputDecoration(
          counter: SizedBox.shrink(),
          border: InputBorder.none,
          hintText: 'Rename',
          hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              color: Theme.of(context).primaryColor),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Color(0xFFF1F4F8),
          //     width: 2,
          //   ),
          //   borderRadius: BorderRadius.circular(8),
          // ),
        ),
      ),
    );
  }
}
