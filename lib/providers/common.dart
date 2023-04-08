import 'package:flashcards/models/profile.dart';
import 'package:flashcards/models/user.dart';
import 'package:flutter/cupertino.dart';
import '../models/deck.dart';

class CommonProvider extends ChangeNotifier {
  List cards = [];
  // ProfileModel? profile;
  // List<DeckModel>? decks = [];
  String currentId = "";
  void setCards(List data) {
    cards = data;
    notifyListeners();
  }

  void setCurrentId(String id) {
    currentId = id;
    notifyListeners();
  }

  // void setUser(ProfileModel data) {
  //   profile = data;
  //   notifyListeners();
  // }

  // void setDecks(dynamic data) {
  //   decks = data;
  //   notifyListeners();
  // }
}
