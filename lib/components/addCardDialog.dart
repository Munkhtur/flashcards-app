import 'package:flashcards/providers/common.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/shared/constants.dart';
import 'package:flutter/material.dart';
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
      // height: 1000,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Card',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: CustomInput(labelText: "Term", hintText: 'Term')
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
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
            Container(
              // height: 300,
              child: TextFormField(
                maxLines: 5, // <-- SEE HERE
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration:
                    CustomInput(labelText: "Example", hintText: 'Example')
                        .getInputEcoration(),
                // .copyWith(
                //   contentPadding: EdgeInsets.symmetric(
                //       vertical: 50), // Adjust the vertical padding
                // ),
                validator: (val) => val!.isEmpty ? '' : null,
                initialValue: description,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  DatabaseService(uid: user.uid).updateCardData(
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
