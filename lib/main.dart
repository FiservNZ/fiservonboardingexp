import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/screens/home_page.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';
import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'controllers/quiz controllers/initial_bindings.dart';
import 'routes/quiz_test_routes.dart';

//import 'screens/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'routes/routes.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  InitialBindings().dependencies();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const QuizApp(),
    ),
  ); // Initialize ThemeProvider here
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: FiservAppRoutes.routes(),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fiservonboardingexp/screens/menu%20drawer/feedback_page.dart';
// import 'package:fiservonboardingexp/screens/home_page.dart';
// import 'package:fiservonboardingexp/screens/login_page.dart';
// import 'package:fiservonboardingexp/screens/main_screen.dart';
// import 'package:fiservonboardingexp/themes/theme_provider.dart';
// import 'package:fiservonboardingexp/controllers/check_user.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:fiservonboardingexp/firebase%20references/firebase_options.dart';
// import 'package:fiservonboardingexp/controllers/read_controller.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// import 'controllers/quiz controllers/initial_bindings.dart';
// import 'routes/quiz_test_routes.dart';
// import 'routes/routes.dart';

// //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// int? initScreen;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   InitialBindings().dependencies();

//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   Get.put(ReadController());

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeProvider(), // Initialize ThemeProvider here
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       //initialRoute: '/',
//       getPages: AppRoutes.routes(),
//     );
//   }
// }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fiservonboardingexp/theme/theme_provider.dart';
// import 'package:fiservonboardingexp/widgets/check_user.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:fiservonboardingexp/firebase_options.dart';

// import 'package:flutter/services.dart';

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
//       home: CheckUser(),
//     );
//   }
// }
