import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

// Interacts with Firebase
class FaqList extends StatelessWidget {
  const FaqList({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    // Changes in the FAQ collection in firestore
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('FAQ').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // Loading animation while getting the FAQ questions and answers
          return const CircularProgressIndicator();
        }

        final faqlist = snapshot.data!.docs;

        return ListView.builder(
          itemCount: faqlist.length,
          itemBuilder: (context, index) {
            final data = faqlist[index].data() as Map<String, dynamic>;

            // Gets the question and answers from firestore data
            final question = data['question'] as String? ?? 'No questions';
            final answer = data['answer'] as String? ?? 'No answers';

            // The UI part of the FAQ List (Font, text size, text colour, alignment)
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
              child: ExpansionTile(
                title: Text(
                  question,
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      color:
                          selectedTheme.colorScheme.primary, // Question Colour
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      answer,
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: selectedTheme
                              .colorScheme.secondary, // Answer Colour
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
