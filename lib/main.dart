import 'package:fiservonboardingexp/firebase_references/firebase_options.dart';
import 'package:fiservonboardingexp/routes/routes.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/elle_testing/controllers/initial_bindings.dart';
import 'package:fiservonboardingexp/util/elle_testing/routes/app_routes.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //InitialBindings().dependencies();
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: FiservAppRoutes.routes(),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fiservonboardingexp/firebase_references/firebase_options.dart';
// import 'package:fiservonboardingexp/util/mc_testing/module_screen.dart';
// import 'package:fiservonboardingexp/widgets/check_user.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// int? initScreen;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Fiserv Onboarding',
//       themeMode: ThemeMode.system,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ModuleScreen(),
//     );
//   }
// }