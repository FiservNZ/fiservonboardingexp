import 'package:fiservonboardingexp/main.dart';
import 'package:flutter/material.dart';
import 'app_bar_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarOverlay(),
      body: Column(
        children: <Widget>[
          //Heading

          const Text(
            '\n Settings',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6600),
            ),
          ),

          //Spacing
          const SizedBox(
            width: double.infinity,
            height: 150,
          ),

          //Dark Mode
          ListTile(
              title: const Text('Dark/Light Mode'),
              leading: const Icon(Icons.lightbulb),
              onTap: () {
                Get.isDarkMode
                    ? Get.changeTheme(ThemeData.light())
                    : Get.changeTheme(ThemeData.dark());
              }),

          //Change password

          ListTile(
              title: const Text('Change Password'),
              leading: const Icon(Icons.change_circle_outlined),
              onTap: () {}),

          //Logout Button
          ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginPage();
                    },
                  ),
                  (_) => false,
                );
              }),

          //Close button
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Color(0xFFFF6600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
