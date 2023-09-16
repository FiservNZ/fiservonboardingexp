import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/widgets/exp_bar.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_provider.dart';
import '../util/achievement_components/incompleted_achievement.dart';
import '../widgets/app_bar_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<String> fetchRandomQuote() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final quoteText = data['content'];
      final quoteAuthor = data['author'];
      return '$quoteText - $quoteAuthor';
    } else {
      return 'Failed to fetch quote';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    final currentUser = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: selectedTheme.colorScheme.background,
        appBar: AppBarOverlay(
          currentUser: currentUser,
        ),
        bottomNavigationBar: const CustomNavBar(),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/randShapes.png"),
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.15), BlendMode.modulate),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: ListView(
              children: [
                const SizedBox(height: 15),

                // Getting user name
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("User")
                      .doc(currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final firstName = userData['firstName'] ?? 'First Name';
                      final lastName = userData['lastName'] ?? 'Last Name';

                      return Stack(
                        children: [
                          Positioned(
                            top: 20, // Icon UP AND DOWN ADJUSTMENT
                            right: 30, // Icon LEFT AND RIGHT ADJUSTMENT
                            child: getUserIcon(userData, selectedTheme),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Welcome message + name
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome back,',
                                      style: TextStyle(
                                        color:
                                            selectedTheme.colorScheme.secondary,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '$firstName $lastName',
                                      style: TextStyle(
                                        color:
                                            selectedTheme.colorScheme.secondary,
                                        fontSize: 21,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Display exp bar
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                child: const ExpBar(barwidth: 225),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return CircularProgressIndicator();
                  },
                ),

                const SizedBox(height: 30),

                // Achievement title text
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text(
                          'Achievements',
                          style: TextStyle(
                            color: selectedTheme.colorScheme.secondary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Achievement tiles
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: IncompletedAchievement(),
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Getting the user icon widget
Widget getUserIcon(Map<String, dynamic> userData, ThemeData selectedTheme) {
  final selectedIcon = userData['selectedIcon'];
  final iconColor =
      Color(int.parse(userData['iconColor'].replaceFirst('#', '0xFF')));
  // Change the icon size here
  double iconSize = 100.0;

  switch (selectedIcon) {
    case 'ghost':
      return Container(
        width: iconSize,
        height: iconSize,
        child: Icon(FontAwesomeIcons.ghost, color: iconColor, size: iconSize),
      );
    case 'seedling':
      return Container(
        width: iconSize,
        height: iconSize,
        child:
            Icon(FontAwesomeIcons.seedling, color: iconColor, size: iconSize),
      );
    case 'poo':
      return Container(
        width: iconSize,
        height: iconSize,
        child: Icon(FontAwesomeIcons.poo, color: iconColor, size: iconSize),
      );
    case 'fish':
      return Container(
        width: iconSize,
        height: iconSize,
        child: Icon(FontAwesomeIcons.fish, color: iconColor, size: iconSize),
      );
    case 'userNinja':
      return Container(
        width: iconSize,
        height: iconSize,
        child:
            Icon(FontAwesomeIcons.userNinja, color: iconColor, size: iconSize),
      );
    case 'dog':
      return Container(
        width: iconSize,
        height: iconSize,
        child: Icon(FontAwesomeIcons.dog, color: iconColor, size: iconSize),
      );
    case 'cat':
      return Container(
        width: iconSize,
        height: iconSize,
        child: Icon(FontAwesomeIcons.cat, color: iconColor, size: iconSize),
      );
    case 'frog':
      return Container(
        width: iconSize,
        height: iconSize,
        child: Icon(FontAwesomeIcons.frog, color: iconColor, size: iconSize),
      );
    case 'robot':
      return Container(
        width: iconSize,
        height: iconSize,
        child: Icon(FontAwesomeIcons.robot, color: iconColor, size: iconSize),
      );
    default:
      return Container(
        width: iconSize,
        height: iconSize,
        child: Icon(Icons.person,
            color: selectedTheme.colorScheme.secondary, size: iconSize),
      );
  }
}

// PREVIOUS HOMEPAGE IMPLEMENTATION HERE LEFT IT JUST INCASE SOME1 NEEDS IT NO PROBLEM

// class HomePage extends StatelessWidget {
//   final ExpBar _expBar = const ExpBar(barwidth: 300);
//   final ProgressBar _progressBar = const ProgressBar();

//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     ThemeData selectedTheme = themeProvider.currentTheme;
//     ReadController readController = Get.find();

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: selectedTheme.colorScheme.background,
//         appBar: const AppBarOverlay(),
//         bottomNavigationBar: const CustomNavBar(),

//         //Floating action button
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.green,
//           foregroundColor: Colors.white,
//           onPressed: () {
//             int expToAdd = 200;
//             _expBar.addExperience(expToAdd);
//           },
//           child: const Icon(Icons.navigation),
//         ),

//         //Home Page
//         body: SafeArea(
//           child: ListView(
//             children: [
//               const SizedBox(height: 15),

//               //expBar
//               Padding(
//                 padding: const EdgeInsets.only(left: 12),
//                 child:
//                     Container(alignment: Alignment.centerLeft, child: _expBar),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),

//               const SizedBox(height: 30),

//               //Progress bar
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Container(
//                     alignment: Alignment.centerLeft, child: _progressBar),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               // IncompletedAchievement
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Container(
//                   alignment: Alignment.centerLeft,
//                   child: IncompletedAchievement(),
//                 ),
//               ),
//               const SizedBox(height: 200),

//               //Read task for platypus article
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 120),
//                 child: ElevatedButton(
//                   onPressed: () {
//                    readController
//                        .setSelectedIndex(0); // Set the desired index here
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                       builder: (context) => ReadPage(),
//                      ),
//s                    );
//                  },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: selectedTheme.colorScheme.onBackground,
//                     fixedSize: Size(120, 35),
//                   ),
//                   child: Text(
//                     'Read Task',
//                     style: TextStyle(
//                       color: selectedTheme.colorScheme.secondary,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ).merge(GoogleFonts
//                         .quicksand()), // Merge styles with GoogleFonts
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
