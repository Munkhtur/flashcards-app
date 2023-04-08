import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards/models/profile.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/providers/common.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flashcards/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    // final value = DatabaseService(uid: user.uid).getProfile();
    final value = Provider.of<CommonProvider>(context);
    return Container(
        child: Column(
      children: [
        Text(value.profile.name),
        Text(value.profile.numOfCards.toString()),
        Text(value.profile.numOfDecks.toString()),
        Text(value.profile.numOfMasterd.toString()),
        ElevatedButton(
          onPressed: (() async {
            await _auth.signOut();
          }),
          child: Text('logout'),
        )
      ],
    ));
  }
}
