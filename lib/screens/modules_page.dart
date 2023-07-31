import 'package:flutter/material.dart';

class ModulesPage extends StatelessWidget {
  const ModulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 16, left: 16),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Modules Page',
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
