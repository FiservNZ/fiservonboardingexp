import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/screens/task%20pages/read_page.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../firebase references/firebase_refs.dart';
import '../../../model/read_model.dart';

class ReadThumbnail extends StatelessWidget {
  final String readTitle;
  final String readDescription;
  final String taskCategory;

  const ReadThumbnail({
    super.key,
    required this.readTitle,
    required this.taskCategory,
    required this.readDescription,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    return GestureDetector(
      onTap: () {
        debugPrint('Read Tapped!\nTitle: $readTitle');
        FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser.uid)
            .collection('Tasks')
            .doc(taskCategory)
            .collection('Read')
            .where('title',
                isEqualTo:
                    readTitle) // Add this filter to fetch the specific quiz
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            QueryDocumentSnapshot doc = querySnapshot.docs.first;
            String documentId = doc.id;
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            // Create a QuizModel instance using the retrieved data
            ReadModel readModel = ReadModel(
              id: documentId,
              title: data['title'],
              description: data['description'],
              time: data['time'],
              isDone: data['isDone'],
              content: data['content'],
              imageUrl: data['image_url'],
            );
            debugPrint("Document ID: $documentId");
            Get.to(ReadPage(readModel: readModel));
          }
        }).catchError((error) {
          debugPrint('ERROR: $error');
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selectedTheme.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/icon/read_thumbnail_icon.png',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  readTitle,
                  style: TextStyle(
                    color: selectedTheme.colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ).merge(GoogleFonts.quicksand()),
                ),
                const SizedBox(height: 5),
                //Wraped in SizedBox to set a preferred width to clip text overflow
                SizedBox(
                  width: 270,
                  child: Text(
                    'Description: $readDescription',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: selectedTheme.colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ).merge(GoogleFonts.quicksand()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
