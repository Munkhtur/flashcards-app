import 'package:flashcards/models/user.dart';
import 'package:flashcards/screens/authenticate/authenticate.dart';
import 'package:flashcards/screens/home/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return user == null ? Authenticate() : Home();
  }
}
