import 'package:flashcards/providers/common.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class AddCardForm extends StatefulWidget {
  final String collectionId;
  const AddCardForm({super.key, required this.collectionId});

  @override
  State<AddCardForm> createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  final _formKey = GlobalKey<FormState>();

  String question = '';
  String answer = "";
  String description = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final profile = Provider.of<CommonProvider>(context).profile;

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Add New Card',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration:
                  CustomInput(labelText: "New word", hintText: 'New word')
                      .getInputEcoration(),
              validator: (val) => val!.isEmpty ? '' : null,
              initialValue: question,
              onChanged: (value) {
                setState(() {
                  question = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration:
                  CustomInput(labelText: "Definition", hintText: 'Definition')
                      .getInputEcoration(),
              validator: (val) => val!.isEmpty ? '' : null,
              initialValue: answer,
              onChanged: (value) {
                setState(() {
                  answer = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration:
                  CustomInput(labelText: "Example use", hintText: 'Example use')
                      .getInputEcoration(),
              validator: (val) => val!.isEmpty ? '' : null,
              initialValue: description,
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              child: Text('Save'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await DatabaseService(uid: user.uid).updateCardData(
                      question,
                      answer,
                      user.uid,
                      widget.collectionId,
                      description,
                      profile.numOfCards);

                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
