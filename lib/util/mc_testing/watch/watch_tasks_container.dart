import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/mc_testing/quiz/quiz_tasks.dart';
import 'package:fiservonboardingexp/util/mc_testing/read/read_tasks.dart';
import 'package:fiservonboardingexp/util/mc_testing/watch/watch_tasks.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WatchTasksContainer extends StatelessWidget {
  final String watchCategory;
  const WatchTasksContainer({super.key, required this.watchCategory});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      backgroundColor: selectedTheme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Watch Tasks:',
                style: TextStyle(
                        color: selectedTheme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)
                    .merge(GoogleFonts.quicksand()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Expanded(
                child: FutureBuilder<List<Widget>>(
                  future: getWatchTaskWidgets(watchCategory),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: $snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                        'No WATCH TASKS for this Category.',
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts.quicksand()),
                      ));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return snapshot.data![index];
                        },
                      );
                    }
                  }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Read Tasks:',
                style: TextStyle(
                        color: selectedTheme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)
                    .merge(GoogleFonts.quicksand()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Expanded(
                child: FutureBuilder<List<Widget>>(
                  future: getReadTaskWidgets(watchCategory),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: $snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                        'No READ TASKS for this Category.',
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts.quicksand()),
                      ));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return snapshot.data![index];
                        },
                      );
                    }
                  }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quiz Tasks:',
                style: TextStyle(
                        color: selectedTheme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)
                    .merge(GoogleFonts.quicksand()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Expanded(
                child: FutureBuilder<List<Widget>>(
                  future: getQuizTaskWidgets(watchCategory),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: $snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                        'No QUIZ TASKS for this Category.',
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts.quicksand()),
                      ));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return snapshot.data![index];
                        },
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
