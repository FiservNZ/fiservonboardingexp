import 'package:fiservonboardingexp/task_setup.dart';
import 'package:fiservonboardingexp/task_tile.dart';
import 'package:fiservonboardingexp/util/my_tasks.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'task.dart';
import 'util/constants.dart';
import 'util/my_box.dart';

class SecurityTasks extends StatefulWidget {
  final List _tasks = ['task 1', 'task 2', 'task 3', 'task 4'];

  List<String> titles = [
    'Title 1',
    'Title 2',
    'Title 3',
    'Title 4',
    'Title 5',
    'Title 6'
  ];

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
                    const SizedBox(height: 10),
                    //heading
                    Text(
                      "Security Tasks",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 30, color: fiservColor),
                    ),
                    const SizedBox(height: 10),
                    //list of tasks
                    Expanded(
                      child: Material(
                        child: ListView.builder(
                            itemCount: value.tasklist.length,
                            itemBuilder: (context, index) {
                              // get task info
                              Task task = value.tasklist[index];
                              //String title = _tasks[index];
                              return TaskTile(
                                task: task,
                                context: context,
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
