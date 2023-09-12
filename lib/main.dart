import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/screens/feedback_page.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/widgets/check_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/firebase_references/firebase_options.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_controller.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(ReadController());

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Initialize ThemeProvider here
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fiserv Onboarding',
      home: CheckUser(),
    );
  }
}
