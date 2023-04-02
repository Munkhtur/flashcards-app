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
    // final profile = Provider.of<ProfileModel>(context);
    final user = Provider.of<UserModel>(context);
    // final profile = DatabaseService(uid: user.uid).profile;
    // print({"profiel": profile});
    return StreamProvider<ProfileModel?>.value(
      value: DatabaseService(uid: user.uid).profile,
      initialData: null,
      child: Consumer<ProfileModel>(builder: (context, value, child) {
        return Container(
            child: Column(
          children: [
            Text(value.name),
            Text(value.numOfCards.toString()),
            Text(value.numOfDecks.toString()),
            Text(value.numOfMasterd.toString()),
            ElevatedButton(
              onPressed: (() async {
                await _auth.signOut();
              }),
              child: Text('logout'),
            )
          ],
        ));
      }),
    );
  }
}
