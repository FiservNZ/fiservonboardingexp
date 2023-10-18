// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/widgets/exp_bar.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
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
    ThemeData selectedTheme = getSelectedTheme(context);
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
                  image: const AssetImage("assets/images/randShapes.png"),
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
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                child: ExpBar(barwidth: 225),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
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
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: Icon(FontAwesomeIcons.ghost, color: iconColor, size: iconSize),
      );
    case 'seedling':
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child:
            Icon(FontAwesomeIcons.seedling, color: iconColor, size: iconSize),
      );
    case 'poo':
      return SizedBox(
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
