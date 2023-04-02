import 'dart:html';

import 'package:flashcards/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class titleBox extends StatefulWidget {
  final Function onTap;
  final Function setname;
  String oldTitle;
  String id;
  titleBox({
    super.key,
    required this.onTap,
    required this.oldTitle,
    required this.id,
    required this.setname,
  });

  @override
  State<titleBox> createState() => _titleBoxState();
}

class _titleBoxState extends State<titleBox> {
  TextEditingController _controller = new TextEditingController();
  FocusNode myfocus = FocusNode();
  String title = "";

  @override
  void initState() {
    title = widget.oldTitle;
    _controller.text = title;
    myfocus.addListener(() {
      if (myfocus.hasFocus) {
      } else {
        widget.onTap();
        widget.setname(title);
        DatabaseService().updateDeckName(title, widget.id);
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
        onChanged: (value) {
          setState(() {
            title = value;
          });
        },
        style: TextStyle(color: Colors.white),
        controller: _controller,
        focusNode: myfocus,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Rename',
          hintStyle:
              TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFF1F4F8),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
