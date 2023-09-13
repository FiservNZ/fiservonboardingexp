import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:fiservonboardingexp/screens/feedback_page.dart';
import 'package:get/get.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class AppBarOverlay extends StatelessWidget implements PreferredSizeWidget {
  const AppBarOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    final rankTitleMap = {
      1: 'Novice 1',
      2: 'Novice 2',
      3: 'Novice 3',
      4: 'Novice 4',
      5: 'Novice 5',
      6: 'Novice 6',
      7: 'Novice 7',
      8: 'Novice 8',
      9: 'Novice 9'
    };

    return SafeArea(
      child: AppBar(
        backgroundColor: selectedTheme.colorScheme.tertiary,
        elevation: 0.0,

        // Profile picture icon
        leading: IconButton(
          icon: const Image(image: AssetImage('assets/images/profile.png')),
          onPressed: () {
            // Get.offAndToNamed deletes home page off the stack
            Get.toNamed("/profile");
          },
        ),

        // Rank Title
        title: Center(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            // reference from file
            stream: userColRef.doc(currentUser.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final userDocument =
                    snapshot.data!.data() as Map<String, dynamic>;
                final level = userDocument['Level'] ?? 0;
                var rankTitle = rankTitleMap[level] ?? 'Unknown';

                return Text(
                  rankTitle,
                  style: TextStyle(
                    color: selectedTheme.colorScheme.secondary,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ).merge(
                      GoogleFonts.quicksand()), // Merge styles with GoogleFonts
                );
              } else {
                return const Text('No data available');
              }
            },
          ),
        ),

        // Nav draw
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: selectedTheme.colorScheme.secondary,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 350,
                    color: selectedTheme.colorScheme.tertiary,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          //Intro teaser
                          ListTile(
                            leading: Icon(
                              Icons.list,
                              color: selectedTheme.colorScheme.secondary,
                            ),
                            title: Text(
                              'Intro Teaser',
                              style: TextStyle(
                                color: selectedTheme.colorScheme.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ).merge(GoogleFonts
                                  .quicksand()), // Merge styles with GoogleFonts
                            ),
                            onTap: () {
                              Get.toNamed("/teaser");
                            },
                          ),

                          // Help pop up
                          ListTile(
                            leading: Icon(
                              Icons.question_mark,
                              color: selectedTheme.colorScheme.secondary,
                            ),
                            title: Text(
                              'Help',
                              style: TextStyle(
                                color: selectedTheme.colorScheme.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ).merge(GoogleFonts
                                  .quicksand()), // Merge styles with GoogleFonts
                            ),
                            onTap: () {
                              Get.toNamed("/help");
                            },
                          ),

                          // FAQ
                          ListTile(
                            leading: Icon(
                              Icons.question_answer,
                              color: selectedTheme.colorScheme.secondary,
                            ),
                            title: Text(
                              'FAQ',
                              style: TextStyle(
                                color: selectedTheme.colorScheme.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ).merge(GoogleFonts
                                  .quicksand()), // Merge styles with GoogleFonts
                            ),
                            onTap: () {
                              Get.toNamed("/faq");
                            },
                          ),

                          // Settings
                          ListTile(
                            leading: Icon(
                              Icons.settings,
                              color: selectedTheme.colorScheme.secondary,
                            ),
                            title: Text(
                              'Settings',
                              style: TextStyle(
                                color: selectedTheme.colorScheme.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ).merge(GoogleFonts
                                  .quicksand()), // Merge styles with GoogleFonts
                            ),
                            onTap: () {
                              Get.toNamed("/settings");
                            },
                          ),

                          // Feedback
                          ListTile(
                            leading: Icon(
                              Icons.feedback_outlined,
                              color: selectedTheme.colorScheme.secondary,
                            ),
                            title: Text(
                              'Feedback',
                              style: TextStyle(
                                color: selectedTheme.colorScheme.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ).merge(GoogleFonts
                                  .quicksand()), // Merge styles with GoogleFonts
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const FeedBack()),
                              );
                            },
                          ),

                          const SizedBox(
                            width: double.infinity,
                            height: 65,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
