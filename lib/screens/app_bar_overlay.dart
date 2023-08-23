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

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0, //Removes the app bar shadow

        // Profile picture icon
        leading: Row(
          children: [
            IconButton(
              icon: const Image(image: AssetImage('assets/images/profile.png')),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ],
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
