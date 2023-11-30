import 'package:firebase_core/firebase_core.dart';
import 'package:flashcards/firebase_options.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/providers/common.dart';
import 'package:flashcards/screens/wrapper.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flashcards/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          value: AuthService().user,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (_) => CommonProvider(),
        ),
      ],
      child: MyApp(),
    ),
    // MyApp()
  );
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> fbApp = Firebase.initializeApp();
  MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<CommonProvider>(context);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      title: 'Flutter Demo',
      home: Wrapper(),
    );
  }
}
