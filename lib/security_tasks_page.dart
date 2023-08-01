import 'package:fiservonboardingexp/task_setup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'task_tile.dart';
import 'util/constants.dart';

class SecurityTasks extends StatefulWidget {
  @override
  State<SecurityTasks> createState() => _SecurityTaskPage();
}

class _SecurityTaskPage extends State<SecurityTasks> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskSetUp>(
      builder: (context, value, child) => SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                //heading
                Text(
                  "Security Tasks",
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
