import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Color(0xFF264653),
  backgroundColor: Color(0xFFfcfcfc),
  secondaryHeaderColor: Color(0xFFe76f51),
  toggleableActiveColor: Color(0xFF264653),
  cardColor: Color(0xFFfcfcfc),

  primaryTextTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF264653),
    ),
  ),
  // textTheme: TextTheme(
  //   subtitle2: TextStyle(
  //     color: Colors.black,
  //   ),
  // ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Color(0xFFe76f51),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(16.0),
      textStyle: const TextStyle(fontSize: 20),
    ),
  ),
);

final darkTheme = ThemeData(
  toggleableActiveColor: Colors.white,
  primaryColor: Color(0xFF264653),
  accentColor: Colors.white,
  backgroundColor: Color(0xFF3F5971),
  secondaryHeaderColor: Color(0xFFe76f51),
  brightness: Brightness.dark,
  cardColor: Color.fromARGB(255, 53, 73, 92),
  primaryTextTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Color(0xFFe76f51),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(16.0),
      textStyle: const TextStyle(fontSize: 20),
    ),
  ),
);
