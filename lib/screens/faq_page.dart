import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/app_bar_overlay.dart';
import '../widgets/faq_list.dart';
import 'package:google_fonts/google_fonts.dart';

// Handles the UI for FAQ page
class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOverlay(),
      bottomNavigationBar: CustomNavBar(),
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Frequently asked questions',
                style: GoogleFonts.quicksand(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: fiservColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FaqList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
