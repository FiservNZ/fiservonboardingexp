import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

class OrientationScreen extends StatelessWidget {
  const OrientationScreen({super.key});
  static const String routeName = '/Orientation';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      body: Center(child: Text('Orientation Screen')),
    );
  }
}
