import 'package:flutter/material.dart';

class CustomInput {
  final context;
  String labelText;
  String hintText;

  CustomInput({this.context, required this.labelText, required this.hintText});

  InputDecoration getInputEcoration() {
    var textInputDecoration = InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(color: Color(0xFFe76f51)),
      hintStyle: TextStyle(color: Color.fromARGB(255, 33, 19, 4)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFF1F4F8),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          // color: Color(0x00000000),
          color: Color(0xFFe76f51),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFe76f51),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
    );

    return textInputDecoration;
  }
}
