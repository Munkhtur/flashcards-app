import 'dart:async';
// import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List cards = [];
  late ProfileModel _data;

  Future<void> getProfile(String documentId) async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection('profiles').doc(documentId).get();

    if (documentSnapshot.exists) {
      _data =
          ProfileModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);

      notifyListeners();
    }
  }

  ProfileModel get profile => _data;

  String currentId = "";

  void setCurrentId(String id) {
    currentId = id;
    notifyListeners();
  }

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  String getTheme() {
    if (_themeMode == ThemeMode.dark) {
      return "Dark";
    } else if (_themeMode == ThemeMode.light) {
      return "Light";
    } else {
      return "System";
    }
  }
}
