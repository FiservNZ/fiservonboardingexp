import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

class CustomsCultureScreen extends StatelessWidget {
  const CustomsCultureScreen({super.key});
  static const String routeName = '/Customs&Culture';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      body: Center(child: Text('Customs & Culture Screen')),
    );
  }
}
