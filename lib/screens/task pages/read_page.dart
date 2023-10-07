import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/mc_testing/module/module_screen.dart';
import 'package:fiservonboardingexp/util/mc_testing/watch/watch_tasks_container.dart';
import 'package:fiservonboardingexp/util/progress_curr_points.dart';
import 'package:fiservonboardingexp/widgets/exp_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../firebase references/firebase_refs.dart';
import '../../model/read_model.dart';

class ReadPage extends StatelessWidget {
  final ReadModel readModel;
  static const routeName = "/readPage";

  const ReadPage({
    super.key,
    required this.readModel,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      appBar: myAppBar,
      //bottomNavigationBar: navBar,
      body: SafeArea(
          child: ListView(
        children: [
          const SizedBox(height: 30),

          // Title
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(
              // Displays the title of the read task
              readModel.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: selectedTheme.colorScheme.secondary,
                ),
              ),
            ),
          ),

          // Image (from local assets folder not firebase). Needs to be changed as its hard coded.
          Padding(
            padding: EdgeInsets.all(40.0),
            // child: Image(image: AssetImage('assets/images/Read.jpg')),
            child: readModel.imageUrl != ""
                ? Image.network(readModel.imageUrl!)
                : const Image(image: AssetImage('assets/images/Read.jpg')),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (readModel.content.isNotEmpty)
                  // Displays the content of the read task
                  ...readModel.content.split(r'\n\n').map((paragraph) {
                    // Replace '\n' with two new lines '\n\n', and trim leading/trailing spaces.
                    // Flutter will then recognise this as two new lines and saves as a paragraph.
                    final trimmedParagraph =
                        paragraph.replaceAll(r'\n\n', '\n' '\n').trim();
                    return Column(
                      children: [
                        // Display the trimmed paragraph as text.
                        Text(
                          trimmedParagraph,
                          style: TextStyle(
                            fontSize: 18,
                            color: selectedTheme.colorScheme.primary,
                          ),
                        ),
                        // Add space (SizedBox) between paragraphs.
                        const SizedBox(height: 16.0),
                      ],
                    );
                  }).toList()
                else
                  Text(
                    'No Content',
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedTheme.colorScheme.primary,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // Puts the two buttons in a row so it is positioned side by side
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTheme.colorScheme.tertiary,
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: selectedTheme.colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ).merge(GoogleFonts
                        .quicksand()), // Merge styles with GoogleFonts
                  ),
                ),

                // Task finished button
                ElevatedButton(
                  // When clicked it adds a point to the progress bar and closes the page.
                  onPressed: () async {
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor:
                              selectedTheme.colorScheme.onBackground,
                          title: Text(
                            'Confirmation',
                            style: TextStyle(
                              color: selectedTheme.colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ).merge(GoogleFonts.quicksand()),
                          ),
                          content: Text(
                            "If you want to mark the task as done, click 'Yes.' To continue reading, click 'No.'",
                            style: TextStyle(
                              color: selectedTheme.colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ).merge(GoogleFonts.quicksand()),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // User clicked No, close the dialog and don't add EXP
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: selectedTheme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ).merge(GoogleFonts.quicksand()),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // User clicked Yes, add EXP
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: selectedTheme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ).merge(GoogleFonts.quicksand()),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirm == true) {
                      ExpBar expBar = const ExpBar(barwidth: 1);
                      expBar.addExperience(25);

                      final querySnapshot = await userColRef
                          .doc(currentUser.uid)
                          .collection('Tasks')
                          .doc(currentCategory)
                          .collection('Read')
                          .where('title', isEqualTo: readModel.title)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        final doc = querySnapshot.docs[0];

                        await doc.reference.update({'isDone': true});
                      } else {
                        debugPrint('No Matching Document Found!');
                      }
                      Get.back();
                      Get.back();
                      Get.to(
                          WatchTasksContainer(watchCategory: currentCategory));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTheme.colorScheme.tertiary,
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: selectedTheme.colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ).merge(GoogleFonts.quicksand()),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),
        ],
      )),
    );
  }
}
