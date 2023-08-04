import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'task.dart';
import 'task_setup.dart';
import 'task_tile.dart';

class WeekOnePage extends StatefulWidget {
  const WeekOnePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WeekOnePage createState() => _WeekOnePage();
}

class _WeekOnePage extends State<WeekOnePage> {
  bool showTitle = false;
  List<String> titles = [
    'Title 1',
    'Title 2',
    'Title 3',
    'Title 4',
    'Title 5',
    'Title 6'
  ];

  final List _tasks = ['task 1', 'task 2', 'task 3', 'task 4'];

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
                  "Week One Tasks",
                  style:
                      GoogleFonts.bebasNeue(fontSize: 30, color: fiservColor),
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
        ),
      ),
    );
  }
}
