import 'dart:async';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/card.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/profile.dart';
import 'package:flashcards/providers/common.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String? uid;
  final String? collectionId;
  dynamic data;

  DatabaseService({this.uid, this.collectionId, this.data});
  //collection reference
  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');
  final CollectionReference deckCollection =
      FirebaseFirestore.instance.collection('decks');
  final CollectionReference cardCollection =
      FirebaseFirestore.instance.collection('cards');

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

  Future updateCardData(
    String question,
    String answer,
    String uid,
    String collectionId,
    String description,
  ) async {
    return await cardCollection.doc().set({
      "question": question,
      "answer": answer,
      "uid": uid,
      "collectionId": collectionId,
      "description": description,
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

 Stream<ProfileModel> profile {
    profileCollection.doc(uid).get().then((doc) => {this.data = doc.data()});

    // .map((event) {
    //   Map<String, dynamic> data = event.data()! as Map<String, dynamic>;
    //   return ProfileModel.fromMap(data);
    // });
    return ProfileModel.fromMap(data);
  }

  ProfileModel getProfile() {
    profileCollection.doc(uid).get().then((doc) => {this.data = doc.data()});

    // .map((event) {
    //   Map<String, dynamic> data = event.data()! as Map<String, dynamic>;
    //   return ProfileModel.fromMap(data);
    // });
    return ProfileModel.fromMap(data);
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

  List<FlashCardModel> _cardsListFromSnapshot(QuerySnapshot snapshot) {
    print({"snapshotcardsmdoel": snapshot});
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return FlashCardModel(
          question: data['question'] ?? "",
          uid: data['uid'] ?? "",
          id: doc.reference.id,
          answer: data['answer'],
          collectionId: data['collectionId'],
          description: data['description']);
    }).toList();
  }

  Stream<List<FlashCardModel>> get cards {
    return cardCollection
        .where("collectionId", isEqualTo: collectionId)
        .snapshots()
        .map(_cardsListFromSnapshot);
  }

  void deleteCard(String id) {
    cardCollection.doc(id).delete().then((doc) => print({"Document deleted"}),
        onError: (e) => print("Error updating document $e"));
  }

  void addToMastered(String id, int cur) async {
    print({"msdter": cur});
    print({"msdter": id});
    cardCollection.doc(id).delete().then((doc) => print({"Document deleted"}),
        onError: (e) => print("Error updating document $e"));
    await profileCollection.doc(uid).update({
      'numOfMastered': cur + 1,
    });
  }

  void deleteDeck(String id) async {
    await cardCollection
        .where("collectionId", isEqualTo: id)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                element.reference.delete();
              })
            });
    await deckCollection.doc(id).delete();
  }
}
