import 'package:flashcards/services/auth.dart';
import 'package:flashcards/shared/constants.dart';
import 'package:flashcards/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = 'admin@gmail.com';
  String password = '123456';
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // if (Theme.of(context).brightness == Brightness.dark)
                              //   Image.asset(
                              //     'assets/images/uiLogo_robinLight@3x.png',
                              //     width: 240,
                              //     height: 60,
                              //     fit: BoxFit.fitWidth,
                              //   ),
                              // if (!(Theme.of(context).brightness == Brightness.dark))
                              //   Image.asset(
                              //     'assets/images/uiLogo_robinDark@3x.png',
                              //     width: 240,
                              //     height: 60,
                              //     fit: BoxFit.fitWidth,
                              //   ),
                            ],
                          ),
                        ),
                        // Image.asset(
                        //   'assets/images/illi_2@2x.png',
                        //   width: 300,
                        //   height: 270,
                        //   fit: BoxFit.cover,
                        // ),
                        Form(
                          key: _formKey,
                          child: Container(
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
                                          'Welcome Back,',
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
                                          validator: (val) =>
                                              val!.isEmpty ? '' : null,
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
                                              .getInputEcoration(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.black),
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
                                          validator: (val) =>
                                              val!.isEmpty ? '' : null,
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
                                              .getInputEcoration()
                                              .copyWith(
                                                suffixIcon: InkWell(
                                                  focusNode: FocusNode(
                                                      skipTraversal: true),
                                                  child: Icon(
                                                    passwordVisibility
                                                        ? Icons
                                                            .visibility_outlined
                                                        : Icons
                                                            .visibility_off_outlined,
                                                    color: Color(0xFF95A1AC),
                                                    size: 22,
                                                  ),
                                                  onTap: () => setState(
                                                    () => passwordVisibility =
                                                        !passwordVisibility,
                                                  ),
                                                ),
                                              ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.black,
                                              ),
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
                                                        Size(double.infinity,
                                                            1))),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() => loading = true);
                                            dynamic result = await _auth
                                                .signInWithEmailandPassword(
                                                    email, password);
                                            if (result == null) {
                                              setState(() {
                                                loading = false;
                                                error =
                                                    'Could not sign in with those credentials';
                                              });
                                            }
                                          }
                                        },
                                        child: const Text('Login'),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 44),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      // backgroundColor: Colors.black,
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.all(16.0),
                                      textStyle: const TextStyle(fontSize: 20),
                                    ),
                                    child: Text(
                                      'Create Account',
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
