import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'profile_page.dart';
import 'faq_page_placeholder.dart';
import 'help_page.dart';
import 'teaser.dart';
import 'settings_page.dart';
import 'package:flutter/material.dart';

class AppBarOverlay extends StatelessWidget implements PreferredSizeWidget {
  const AppBarOverlay({super.key});

  Future<Map<String, dynamic>> getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userCollection = FirebaseFirestore.instance.collection('User');

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await userCollection.doc(currentUser.uid).get();

    if (snapshot.exists) {
      return snapshot.data() ?? {};
    } else {
      return {};
    }
  }

  void LevelUP(int level, double ExpUp) {}
  void AddEXP(double exp) {}

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0, //Removes the app bar shadow

        // Profile picture icon
        leading: IconButton(
          icon: const Image(image: AssetImage('assets/images/profile.png')),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),

        // Exp bar
        title: SizedBox(
          width: 150, // Set the desired width for the SizedBox
          child: Column(
            children: [
              FutureBuilder<Map<String, dynamic>>(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final level = snapshot.data!['Level'] ?? 0;
                    final currentEXP = snapshot.data!['EXP'] ?? 0;
                    final maxEXP = snapshot.data!['MaxEXP'] ?? 100;

                    final expText = 'Level $level  $currentEXP/$maxEXP';

                    return Column(
                      children: [
                        Text(
                          expText,
                          style: const TextStyle(
                              color: Color(0xFFFF6600), fontSize: 16),
                        ),
                        LinearProgressIndicator(
                          value: currentEXP / maxEXP,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFFF6600),
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      ],
                    );
                  } else {
                    return const Text('No data available');
                  }
                },
              ),
            ],
          ),
        ),
        // Menu sheet
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFFF6600)),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 320,
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          //Intro teaser
                          ListTile(
                            leading: const Icon(
                              Icons.list,
                              color: Color(0xFFFF6600),
                            ),
                            title: const Text(
                              'Intro Teaser',
                              style: TextStyle(color: Color(0xFFFF6600)),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const TeaserScreen()),
                              );
                            },
                          ),

                          // Help pop up
                          ListTile(
                            leading: const Icon(
                              Icons.question_mark,
                              color: Color(0xFFFF6600),
                            ),
                            title: const Text(
                              'Help',
                              style: TextStyle(color: Color(0xFFFF6600)),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const HelpPage()),
                              );
                            },
                          ),

                          // FAQ
                          ListTile(
                            leading: const Icon(
                              Icons.question_answer,
                              color: Color(0xFFFF6600),
                            ),
                            title: const Text(
                              'FAQ',
                              style: TextStyle(color: Color(0xFFFF6600)),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => FaqPage()),
                              );
                            },
                          ),

                          // Settings
                          ListTile(
                            leading: const Icon(
                              Icons.settings,
                              color: Color(0xFFFF6600),
                            ),
                            title: const Text(
                              'Settings',
                              style: TextStyle(color: Color(0xFFFF6600)),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage()),
                              );
                            },
                          ),

                          const SizedBox(
                            width: double.infinity,
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
