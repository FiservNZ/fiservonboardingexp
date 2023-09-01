import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar_overlay.dart';
import '../widgets/faq_list.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Frequently asked questions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
