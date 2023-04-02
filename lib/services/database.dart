import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/profile.dart';
import 'package:flashcards/providers/common.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});
  //collection reference
  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');
  final CollectionReference deckCollection =
      FirebaseFirestore.instance.collection('decks');

  Future updateUserData(
    String name,
    int numOfDecks,
    int numOfCards,
    int numOfMastered,
  ) async {
    return await profileCollection.doc(uid).set({
      'name': name,
      'numOfDecks': 0,
      'numOfCards': 0,
      'numOfMastered': 0,
    });
  }

  Future updateDeckData(String name) async {
    return await deckCollection.doc().set({
      'name': name,
      'uid': this.uid,
    });
  }

  Future updateDeckName(String name, String id) async {
    return await deckCollection.doc(id).update({'name': name});
  }

  // ProfileModel getProfile() {
  //   var data = getProfileFireBase();
  //   print({"getprofiledata": data});
  //   return ProfileModel.fromMap(data);
  // }

  Stream<ProfileModel> get profile {
    return profileCollection.doc(uid).snapshots().map((event) {
      Map<String, dynamic> data = event.data()! as Map<String, dynamic>;
      print({"event": data});
      return ProfileModel.fromMap(data);
    });
  }

  List<DeckModel> _deckListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return DeckModel(
        name: data['name'] ?? "",
        uid: data['uid'] ?? "",
        id: doc.reference.id,
      );
    }).toList();
  }

  Stream<List<DeckModel>> get decks {
    return deckCollection
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map((_deckListFromSnapshot));
  }

  // Future<List<DeckModel>> decks() async {
  //   return await deckCollection
  //       .where('uid', isEqualTo: this.uid)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     return _deckListFromSnapshot(querySnapshot.docs);
  //   });
  // }
}
