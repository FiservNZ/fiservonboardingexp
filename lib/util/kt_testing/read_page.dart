import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/app_bar_overlay.dart';
import '../../widgets/nav_bar.dart';
import '../constants.dart';
import 'package:fiservonboardingexp/widgets/progress_bar.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_controller.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_model.dart';

class ReadPage extends GetView<ReadController> {
  final ProgressBar _progressBar = const ProgressBar();
  final ReadModel model;

  const ReadPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const AppBarOverlay(),
      bottomNavigationBar: const CustomNavBar(),
      body: SafeArea(
        child: FutureBuilder<ReadModel>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is still loading
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If there was an error
              return Text('Error: ${snapshot.error}');
            } else {
              // Data has been loaded successfully
              return ListView(
                children: [
                  const SizedBox(height: 30),

                  // Title
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      model.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: fiservColor),
                      ),
                    ),
                  ),

                  // Image (from local assets folder not firebase). Needs to be changed as its hard coded.
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child:
                        Image(image: AssetImage('assets/images/platypus.webp')),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: RichText(
                      textAlign: TextAlign
                          .justify, // Justify alignment for the entire text
                      text: TextSpan(
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        // Find '\n' in the 'content' field, split it and save into a map called paragraph
                        children: model.content.split('\n').map((paragraph) {
                          return TextSpan(
                            text:
                                '${paragraph.trim()}\n\n', // Add two newlines for paragraph spacing
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Back button
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: fiservColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: fiservColor,
                            ),
                            child: const Text('Back'),
                          ),
                        ),

                        // Task finished button
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: fiservColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              int points = 1;
                              _progressBar.addPoints(points);
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: fiservColor,
                            ),
                            child: const Text('Task Finished'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
