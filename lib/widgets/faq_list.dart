import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../util/faq_item.dart';

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

        final faqDocs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: faqDocs.length,
          itemBuilder: (context, index) {
            final data = faqDocs[index].data() as Map<String, dynamic>;

            final question =
                data['question'] as String? ?? 'No question available';
            final answer = data['answer'] as String? ?? 'No answer available';

            return FaqItem(question: question, answer: answer);
          },
        );
      },
    );
  }
}
