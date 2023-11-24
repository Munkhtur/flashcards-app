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
  Map<String, dynamic>? data;

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
    int numOfCards,
    int numOfMastered,
  ) async {
    return await profileCollection.doc(uid).set({
      'name': name,
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

  Future updateCardData(String question, String answer, String uid,
      String collectionId, String description, int cur) async {
    await cardCollection.doc().set({
      "question": question,
      "answer": answer,
      "uid": uid,
      "collectionId": collectionId,
      "description": description,
    });
    updateProfile("numOfCards", cur + 1);
  }

  Future updateDeckName(String name, String id) async {
    return await deckCollection.doc(id).update({'name': name});
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

  Stream<ProfileModel> get profileStream {
    return profileCollection.doc(uid).snapshots().map(
      (doc) {
        return ProfileModel.fromMap(doc.data() as Map<String, dynamic>?);
      },
    );
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

  void deleteCard(String id, int currentTotal) async {
    cardCollection.doc(id).delete().then((doc) => print({"Document deleted"}),
        onError: (e) => print("Error updating document $e"));
    updateProfile("numOfCards", currentTotal - 1);
  }

  void addToMastered(String id, int cur) async {
    cardCollection.doc(id).delete().then((doc) => print({"Document deleted"}),
        onError: (e) => print("Error updating document $e"));

    updateProfile("numOfMastered", cur + 1);
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

  void updateProfile(String field, int cur) async {
    await profileCollection.doc(uid).update({
      field: cur,
    });
  }
}
