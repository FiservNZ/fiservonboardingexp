import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 16, left: 16),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Profile Page',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
