import 'package:flutter/material.dart';
import 'package:fiservonboardingexp/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fiserv Onboarding App',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
