import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/screens/home_page.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';
import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:fiservonboardingexp/theme/theme_provider.dart';
import 'package:fiservonboardingexp/widgets/check_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/firebase_options.dart';

import 'package:flutter/services.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
int? initScreen;

Future<void> main() async {
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
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckUser(),
    );
  }
}
