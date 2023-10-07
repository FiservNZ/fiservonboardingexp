import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/controllers/load_quiz_tasks.dart';
import 'package:fiservonboardingexp/controllers/load_read_tasks.dart';
import 'package:fiservonboardingexp/controllers/load_watch_tasks.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TasksContainer extends StatelessWidget {
  final String watchCategory;
  const TasksContainer({super.key, required this.watchCategory});

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);

    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      backgroundColor: selectedTheme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 15.0,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Watch Tasks:',
                style: TextStyle(
                        color: selectedTheme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
              alignment: Alignment.center,
              child: Text(
                'Read Tasks:',
                style: TextStyle(
                        color: selectedTheme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
              alignment: Alignment.center,
              child: Text(
                'Quiz Tasks:',
                style: TextStyle(
                        color: selectedTheme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
