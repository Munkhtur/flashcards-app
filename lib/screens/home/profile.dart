import 'package:flashcards/models/user.dart';
import 'package:flashcards/providers/common.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/shared/loading.dart';
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
    var themeProvider = Provider.of<CommonProvider>(context);

    return StreamBuilder(
        initialData: null,
        stream: DatabaseService(uid: user.uid).profileStream,
        builder: (context, value) {
          // final value = snapshot.data?.doc;
          if (value.hasData) {
            return Container(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        width: 2.0, color: Theme.of(context).dividerColor),
                  )),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Profile',
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(
                          value.data!.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Color.fromARGB(255, 185, 185, 185)),
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        width: 2.0, color: Theme.of(context).dividerColor),
                  )),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Metrics',
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('Active cards: '),
                            Text(value.data!.numOfCards.toString()),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('Mastered: '),
                            Text(value.data!.numOfMasterd.toString())
                          ],
                        )
                      ]),
                ),
                InkWell(
                  onTap: () {
                    _setTheme();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                          width: 2.0, color: Theme.of(context).dividerColor),
                    )),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Theme',
                              style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(
                            height: 10,
                          ),
                          Text(themeProvider.getTheme())
                        ]),
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  height: 50.0,
                ),
                InkWell(
                  onTap: (() async {
                    await _auth.signOut();
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground),
                      bottom: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground),
                    )),
                    // width: double.infinity,
                    alignment: Alignment.centerLeft,

                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        "Sign out",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Color(
                                  0xFFe76f51), // Set your desired text color here
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
          } else {
            return Loading();
          }
        });
  }

  Future<void> _setTheme() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          var themeProvider = Provider.of<CommonProvider>(context);
          return SimpleDialog(
            // contentPadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            title: const Text('Theme'),
            children: <Widget>[
              ListTile(
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      themeProvider.setTheme(ThemeMode.system);
                    },
                    child: const Text('System'),
                  ),
                ),
                leading: Radio<ThemeMode>(
                  value: ThemeMode.system,
                  groupValue: themeProvider.themeMode,
                  onChanged: (ThemeMode? value) {
                    themeProvider.setTheme(value!);
                  },
                ),
              ),
              ListTile(
                title: GestureDetector(
                  onTap: () {
                    themeProvider.setTheme(ThemeMode.dark);
                  },
                  child: const Text('Dark'),
                ),
                leading: Radio<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: themeProvider.themeMode,
                  onChanged: (ThemeMode? value) {
                    themeProvider.setTheme(value!);
                  },
                ),
              ),
              ListTile(
                title: GestureDetector(
                  onTap: () {
                    themeProvider.setTheme(ThemeMode.light);
                  },
                  child: const Text('Light'),
                ),
                leading: Radio<ThemeMode>(
                  activeColor: Theme.of(context).toggleableActiveColor,
                  value: ThemeMode.light,
                  groupValue: themeProvider.themeMode,
                  onChanged: (ThemeMode? value) {
                    themeProvider.setTheme(value!);
                  },
                ),
              ),
              ListTile(
                title: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
