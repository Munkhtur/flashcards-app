import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/profile.dart';
import 'package:flutter/cupertino.dart';

class CommonProvider extends ChangeNotifier {
    late StreamSubscription<DocumentSnapshot> _subscription;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List cards = [];
  late ProfileModel _data;

  // MyDataProvider({String collectionName, String documentId}) {
  //   loadData(collectionName, documentId);
  // }

      _subscription = docRef.snapshots().listen((snapshot) {
      // Update the data and notify listeners
      _data =    ProfileModel.fromMap(snapshot.data() as Map<String, dynamic>);
      notifyListeners();
    });

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
}
