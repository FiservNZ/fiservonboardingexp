import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_bar_overlay.dart';
import '../../widgets/nav_bar.dart';
import 'package:fiservonboardingexp/widgets/progress_bar.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_controller.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_model.dart';

class ReadPage extends GetView<ReadController> {
  final ProgressBar _progressBar = const ProgressBar();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      appBar: const AppBarOverlay(),
      bottomNavigationBar: const CustomNavBar(),
      body: SafeArea(
        child: GetBuilder<ReadController>(
          builder: (controller) {
            ReadModel? model; // Declare as nullable and initialize as null

            // Saves the selected document from the read collection as a model
            if (controller.allReadTasks.isNotEmpty) {
              model = controller.allReadTasks[controller.selectedIndex.value];
            }

            return ListView(
              children: [
                const SizedBox(height: 30),

                // Title
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    // Displays the title of the read task
                    model?.title ?? 'No Title',
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
                const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Image(image: AssetImage('assets/images/Read.jpg')),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (model != null)
                        // Displays the content of the read task
                        ...model.content.split(r'\n\n').map((paragraph) {
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
                        onPressed: () {
                          int points = 1;
                          _progressBar.addPoints(points);
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedTheme.colorScheme.tertiary,
                        ),
                        child: Text(
                          'Task Finished',
                          style: TextStyle(
                            color: selectedTheme.colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ).merge(GoogleFonts
                              .quicksand()), // Merge styles with GoogleFonts
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
              ],
            );
          },
        ),
      ),
    );
  }
}
