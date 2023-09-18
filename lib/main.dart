import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/routes/quiz_test_routes.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'controllers/quiz controllers/initial_bindings.dart';
//import 'screens/main_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'firebase references/firebase_options.dart';
import 'routes/routes.dart';

int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  InitialBindings().dependencies();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      initialRoute: '/',
      getPages: FiservAppRoutes.routes(),
    );
  }
}


// // Routes to the read task page
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
//       // Initial route is set to the readtask page
//       initialRoute: '/read',
//       //sets the initial route to homepage with read task button and progess bar
//       //initialRoute: '/',
//       getPages: Routes.routes(),
//     );
//   }
// }



// Old Code
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
