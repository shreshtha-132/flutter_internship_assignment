import 'package:flutter/material.dart';
import 'screens/registration.dart';
import 'screens/home.dart';
import 'screens/landingPage.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LandingPage.id,
      routes: {
        LandingPage.id: (context) => LandingPage(),
        Home.id: (context) => Home(),
        Registration.id: (context) => Registration(),
        Login.id: (context) => Login(),
      },
    );
  }
}
