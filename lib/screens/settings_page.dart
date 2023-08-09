import 'package:flutter/material.dart';
import 'app_bar_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarOverlay(),
        body: Column(children: <Widget>[
          const Text(
            '\n Settings',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6600),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 150,
          ),
          Align(
            alignment: Alignment.center,
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
            ),
          ),
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
        ]));
  }
}
