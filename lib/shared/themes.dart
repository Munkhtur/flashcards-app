import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  dividerColor: const Color.fromARGB(255, 114, 113, 113),
  primaryColor: Color(0xff1f1d2b),
  secondaryHeaderColor: Color(0xFFe76f51),
  cardColor: Color(0xff3a3f55),
  // accentColor: Colors.white,
  brightness: Brightness.light,
  primaryTextTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF264653),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Color(0xFFe76f51),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(16.0),
      textStyle: const TextStyle(fontSize: 20),
      // minimumSize: Size(double.infinity, 48.0),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF264653);
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF264653);
      }
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF264653);
      }
      return null;
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF264653);
      }
      return null;
    }),
  ),
  colorScheme: ColorScheme(
      background: Color(0xFFfcfcfc),
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 54, 55, 53),
      onPrimary: const Color.fromARGB(255, 216, 216, 216),
      secondary: Color.fromARGB(255, 196, 196, 197),
      onSecondary: const Color.fromARGB(255, 54, 133, 244),
      error: Colors.red,
      onError: const Color.fromARGB(255, 193, 192, 192),
      onBackground: Color.fromARGB(255, 102, 102, 102),
      surface: Color.fromARGB(255, 248, 248, 248),
      onSurface: const Color.fromARGB(255, 0, 0, 0)),
);

final darkTheme = ThemeData(
  dividerColor: const Color.fromARGB(255, 150, 150, 150),
  primaryColor: Color(0xff1f1d2b),
  secondaryHeaderColor: Color(0xFFe76f51),
  brightness: Brightness.dark,
  // cardColor: Color(0xff252836),
  cardColor: Color(0xff3a3f55),
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
      minimumSize: Size(10, 48.0),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      return null;
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      return null;
    }),
  ),
  colorScheme: ColorScheme(
      background: Color(0xff1f1d2b),
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 54, 55, 53),
      onPrimary: const Color.fromARGB(255, 255, 255, 255),
      secondary: Color.fromARGB(255, 55, 52, 68),
      onSecondary: const Color.fromARGB(255, 179, 175, 174),
      error: Colors.red,
      onError: const Color.fromARGB(255, 76, 76, 76),
      onBackground: const Color.fromARGB(255, 232, 232, 232),
      surface: Color(0xff1f1d2b),
      onSurface: Color.fromARGB(255, 255, 255, 255)),
);
