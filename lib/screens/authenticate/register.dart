import 'package:flashcards/services/auth.dart';
import 'package:flashcards/shared/constants.dart';
import 'package:flashcards/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String passwordConfirm = '';
  String error = "";
  bool passwordVisibility = false;
  bool loading = false;
  final _unfocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFFF1F4F8),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(),
                child: Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/background2.png',
                          width: 340,
                          height: 350,
                          fit: BoxFit.fitWidth,
                        ),
                        // Image.asset(
                        //   'assets/images/illi_2@2x.png',
                        //   width: 300,
                        //   height: 270,
                        //   fit: BoxFit.cover,
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color(0x24000000),
                                offset: Offset(0, -1),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 16, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Get Started',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 16, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: email,
                                        onChanged: (value) {
                                          setState(() {
                                            email = value;
                                          });
                                        },
                                        obscureText: false,
                                        decoration: CustomInput(
                                                labelText: "Email",
                                                hintText: 'Email')
                                           .getInputEcoration().copyWith(fillColor: Theme.of(context).colorScheme.secondary, labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),hintStyle: TextStyle(color: 
                      Theme.of(context).colorScheme.onBackground)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 16, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: password,
                                        onChanged: (value) {
                                          setState(() {
                                            password = value;
                                          });
                                        },
                                        obscureText: !passwordVisibility,
                                        decoration: CustomInput(
                                                labelText: "Password",
                                                hintText: 'Password')
                                             .getInputEcoration().copyWith(fillColor: Theme.of(context).colorScheme.secondary, labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),hintStyle: TextStyle(color: 
                      Theme.of(context).colorScheme.onBackground)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 16, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: password,
                                        onChanged: (value) {
                                          setState(() {
                                            passwordConfirm = value;
                                          });
                                        },
                                        obscureText: !passwordVisibility,
                                        decoration: CustomInput(
                                                labelText: "Confirm Password",
                                                hintText: 'Confirm Password')
                                            .getInputEcoration().copyWith(fillColor: Theme.of(context).colorScheme.secondary, labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),hintStyle: TextStyle(color: 
                      Theme.of(context).colorScheme.onBackground)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Generated code for this Row-buttonContainer Widget...
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 12, 20, 16),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    TextButton(
                                      style: Theme.of(context)
                                          .elevatedButtonTheme
                                          .style!
                                          .copyWith(
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size(
                                                          double.infinity, 1))),
                                      onPressed: () async {
                                        if (password == passwordConfirm) {
                                          await _auth
                                              .registerWithEmailandPassword(
                                                  email, password);
                                        }
                                      },
                                      child: const Text('Create Account'),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 2,
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                                color: Color(0xFFE0E3E7),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 44),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    // backgroundColor: Colors.black,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.all(16.0),
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                  onPressed: () {
                                    widget.toggleView();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
