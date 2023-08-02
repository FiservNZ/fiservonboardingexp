import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

class UrgentTasksPage extends StatelessWidget {
  const UrgentTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: myAppBar,
      body: Padding(
        padding: EdgeInsets.only(top: 16, left: 16),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Urgent Tasks Page',
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
