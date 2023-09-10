import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../util/faq_item.dart';
import 'package:google_fonts/google_fonts.dart';

// Interacts with Firebase
class FaqList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('FAQ').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final faqlist = snapshot.data!.docs;

        return ListView.builder(
          itemCount: faqlist.length,
          itemBuilder: (context, index) {
            final data = faqlist[index].data() as Map<String, dynamic>;

            final question = data['question'] as String? ?? 'No questions';
            final answer = data['answer'] as String? ?? 'No answers';

            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
              child: ExpansionTile(
                title: Text(
                  question,
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      color: Colors.white, // Question Colour
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
                        textStyle: const TextStyle(
                          color: fiservColor, // Answer Colour
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
