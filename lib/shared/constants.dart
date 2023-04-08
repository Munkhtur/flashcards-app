import 'package:flutter/material.dart';

class CustomInput {
  final context;
  String labelText;
  String hintText;

  CustomInput({this.context, required this.labelText, required this.hintText});

  dynamic getInputEcoration() {
    var textInputDecoration = InputDecoration(
      labelText: labelText,
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFF1F4F8),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
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
          color: Color(0x00000000),
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
