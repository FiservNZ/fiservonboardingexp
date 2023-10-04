import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpList extends StatelessWidget {
  const HelpList({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Help').get();

      if (snapshot.docs.isNotEmpty) {
        final List<Map<String, dynamic>> topicsWithDescriptions = [];

        for (final doc in snapshot.docs) {
          if (doc.exists &&
              doc.data().containsKey('topic') &&
              doc.data().containsKey('description') &&
              doc.data().containsKey('imagePath')) {
            topicsWithDescriptions.add({
              'topic': doc.data()['topic'] as String,
              'description': doc.data()['description'] as String,
              'imagePath':
                  doc.data()['imagePath'] as String, // Image path in Firestore
            });
          }
        }

        return topicsWithDescriptions;
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading indicator
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Text('Error fetching data'); // Error message
        }

        final topicsWithDescriptions = snapshot.data!;

        return ListView.builder(
          itemCount: topicsWithDescriptions.length,
          itemBuilder: (context, index) {
            final topicData = topicsWithDescriptions[index];
            return Container(
              color: selectedTheme.colorScheme.onBackground, // Background color
              child: ExpansionTile(
                title: Text(
                  topicData['topic']!,
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: selectedTheme.colorScheme.primary,
                  ),
                ),
                children: [
                  Image.network(
                    topicData['imagePath'], // Display the image from Firestore
                    height: 200, // Adjust the height as needed
                    width: 100, // Expand to full width
                    fit: BoxFit
                        .cover, // Maintain aspect ratio and cover the entire width
                  ),
                  const SizedBox(
                      height: 8), // Add spacing between image and description
                  ListTile(
                    title: Text(
                      topicData['description']!,
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: selectedTheme.colorScheme.secondary,
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
