import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

class HealthSafetyScreen extends StatelessWidget {
  const HealthSafetyScreen({super.key});
  static const String routeName = '/Health&Safety';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      body: Center(child: Text('Health & Safety Screen')),
    );
  }
}
