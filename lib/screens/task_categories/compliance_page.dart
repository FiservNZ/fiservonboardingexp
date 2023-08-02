import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/task_tile.dart';
import '../../util/constants.dart';
import 'package:fiservonboardingexp/screens/nav_bar.dart';

class SecurityTasks extends StatefulWidget {
  const SecurityTasks({super.key});

  @override
  State<SecurityTasks> createState() => _SecurityTaskPage();
}

class _SecurityTaskPage extends State<SecurityTasks> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: myAppBar,
        bottomNavigationBar: customNavBar(),
        body: Container(
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
