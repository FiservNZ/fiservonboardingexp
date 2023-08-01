import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/task_tile.dart';
import '../../util/constants.dart';

class TechnicalTasks extends StatefulWidget {
  const TechnicalTasks({super.key});

  @override
  State<TechnicalTasks> createState() => _TechnicalTasksPage();
}

class _TechnicalTasksPage extends State<TechnicalTasks> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: myAppBar,
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                //heading
                Text(
                  "Technical Training Tasks",
                  style:
                      GoogleFonts.bebasNeue(fontSize: 30, color: fiservColor),
                ),
                const SizedBox(height: 10),
                //list of tasks
                const Expanded(
                  child: TaskTile(),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
