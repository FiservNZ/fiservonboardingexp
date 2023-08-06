import 'package:fiservonboardingexp/screens/login_page.dart';
import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'profile_page.dart';
import 'faq_page_placeholder.dart';
import 'help_page.dart';
import 'teaser.dart';
import 'logout_page.dart';
import 'settings_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppBarOverlay extends StatelessWidget implements PreferredSizeWidget {
  const AppBarOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,

        // Profile picture icon
        leading: IconButton(
          icon: const Image(image: AssetImage('assets/images/profile.png')),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),

        // Rank Title
        title: const Center(
          child:
              Text('[Rank Title]', style: TextStyle(color: Color(0xFFFF6600))),
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
                    height: 400,
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

                          // Logout
                          ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: Color(0xFFFF6600),
                            ),
                            title: const Text(
                              'Logout',
                              style: TextStyle(color: Color(0xFFFF6600)),
                            ),
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
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
