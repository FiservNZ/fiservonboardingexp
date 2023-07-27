import 'package:fiservonboardingexp/config/app_router.dart';
import 'package:fiservonboardingexp/screens/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fiserv Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //Change home field to the page you want to test.
      home: const LoginApp(),
    );
  }
}
