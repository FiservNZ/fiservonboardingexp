import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/task_tile.dart';

class WeekOnePage extends StatefulWidget {
  const WeekOnePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WeekOnePage createState() => _WeekOnePage();
}

class _WeekOnePage extends State<WeekOnePage> {
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
                //heading
                Text(
                  "Week One Tasks",
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
  }
}
