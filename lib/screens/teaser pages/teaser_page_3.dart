import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeaserPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 245, 218),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top:
                  20.0), // Adjustment of the Text title and subtext (vertically)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/happyppl.png',
                width: 350,
                height: 300,
                fit: BoxFit.contain,
              ),
              Text(
                'Elevate Your Experience!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 81, 0),
                ),
              ),
              SizedBox(
                  height:
                      10), // Adjust the spacing between the title and subtext
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 20, 20),
                child: Text(
                  'Experience the power of gamification in our onboarding app. Learning has never been this enjoyable!',
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
