import 'package:flutter/material.dart';
import '../widgets/app_bar_overlay.dart';
import 'change_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';
import '../widgets/nav_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarOverlay(),
      bottomNavigationBar: const CustomNavBar(),
      body: SafeArea(
        child: Column(
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
              onTap: () {},
            ),

            //Change password
            ListTile(
              title: const Text('Change Password'),
              leading: const Icon(Icons.change_circle_outlined),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ChangePasswordPage();
                }));
              },
            ),

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
              },
            ),

            //Close button
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
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
      ),
    );
  }
}
