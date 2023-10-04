import 'package:flutter/material.dart';

class TeaserPage1 extends StatelessWidget {
  const TeaserPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 232, 232),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top:
                  20.0), // Adjustment of the Text title and subtext (vertically.)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/welcomehandshake.png',
                width: 350,
                height: 350,
                fit: BoxFit.contain,
              ),
              const Text(
                'Welcome to Fiserv',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 81, 0),
                ),
              ),
              const SizedBox(
                  height:
                      10), // Adjust the spacing between the title and subtext
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 20, 20),
                child: Text(
                  'There was something in the tree. It was difficult to tell from the ground, but Rachael could see movement. What she had spied.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
