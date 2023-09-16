import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/constants.dart';
import '../../idk/task_components/task.dart';
import '../../widgets/nav_bar.dart';

class TaskPage extends StatelessWidget {
  final Task task;

  TaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: myAppBar,
        bottomNavigationBar: const CustomNavBar(),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                //title of page pulled from the name field in firestore
                Text(
                  task.name,
                  style:
                      GoogleFonts.bebasNeue(fontSize: 30, color: fiservColor),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
