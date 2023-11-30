import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Color(0xFF264653),
  secondaryHeaderColor: Color(0xFFe76f51),
  cardColor: Color.fromARGB(255, 53, 73, 92),
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
//  colorScheme: ColorScheme(background: Color(0xFFfcfcfc), brightness: Brightness.light, primary: Colors.red),
);

final darkTheme = ThemeData(
  primaryColor: Colors.white,

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
//  colorScheme: ColorScheme(background: Color.fromARGB(255, 30, 29, 29)),
);
