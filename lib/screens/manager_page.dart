import 'package:flutter/material.dart';
import '../util/constants.dart';
import '../widgets/nav_bar.dart';

class ManagerPage extends StatelessWidget {
  const ManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manager page',
          style: TextStyle(color: Color(0xFFFF6600)),
        ),
        backgroundColor: Colors.black,
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, left: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'manager page',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
