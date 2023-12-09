import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/card.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/profile.dart';

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

  Future updateDeckData(
    String name,
  ) async {
    Map<String, dynamic> dataToUpdate = {
      'name': name,
      'uid': this.uid,
      'progress': 0
    };
    DocumentReference docRef = deckCollection.doc();

    await docRef.set(dataToUpdate);

    DocumentSnapshot updatedSnapshot = await docRef.get();

    Map<String, dynamic> data = updatedSnapshot.data()! as Map<String, dynamic>;
    return DeckModel(
      name: data["name"] ?? "",
      uid: data['uid'] ?? "",
      progress: (data["progress"] ?? 0)?.toDouble() ?? 0.0,
      id: updatedSnapshot.id,
    );
  }

  Future updateCardData(String question, String answer, String uid,
      String collectionId, String description, int cur) async {
    try {
      await cardCollection.doc().set({
        "question": question,
        "answer": answer,
        "uid": uid,
        "collectionId": collectionId,
        "description": description,
      });
      updateProfile("numOfCards", cur + 1);

      // The data has been successfully updated (locally, if offline)
      print("Update successful!");
    } catch (e) {
      // Handle errors that might occur during the update
      print("Error updating data: $e");
    }
  }

  Future updateDeckName(
      {String? name, required String id, double? progress}) async {
    Map<String, dynamic> dataToUpdate = {};
    if (progress != null) {
      dataToUpdate['progress'] = progress;
    }
    if (name != null) {
      dataToUpdate['name'] = name;
    }
    return await deckCollection.doc(id).update(dataToUpdate);
  }

  List<DeckModel> _deckListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return DeckModel(
        name: data['name'] ?? "",
        uid: data['uid'] ?? "",
        progress: (data["progress"] ?? 0)?.toDouble() ?? 0.0,
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
