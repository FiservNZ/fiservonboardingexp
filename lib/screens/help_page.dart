import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(children: <Widget>[
      const Text(
        '\n App Tutorial',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFF6600),
        ),
      ),
      const Text('\n\n An instructional guide to help navigate the app'),
      Expanded(
        child: Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainScreen(),
                ),
              );
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
