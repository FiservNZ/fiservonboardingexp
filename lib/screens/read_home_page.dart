import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/controllers/read_controller.dart';
import 'package:fiservonboardingexp/screens/read_page.dart';
import 'package:fiservonboardingexp/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReadHomePage extends StatelessWidget {
  final ProgressBar _progressBar = const ProgressBar();

  const ReadHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    ReadController readController = Get.find();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: selectedTheme.colorScheme.background,

        //Home Page
        body: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 15),

              //Progress bar
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: _progressBar,
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //Read task for platypus article
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: ElevatedButton(
                  onPressed: () {
                    readController
                        .setSelectedIndex(0); // Set the desired index here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTheme.colorScheme.onBackground,
                    // ignore: prefer_const_constructors
                    fixedSize: Size(120, 35),
                  ),
                  child: Text(
                    'Read Task',
                    style: TextStyle(
                      color: selectedTheme.colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ).merge(GoogleFonts
                        .quicksand()), // Merge styles with GoogleFonts
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
