import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

class ComplianceScreen extends StatelessWidget {
  const ComplianceScreen({super.key});
  static const String routeName = '/Compliance';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      body: Center(child: Text('Compliance Screen')),
    );
  }
}
