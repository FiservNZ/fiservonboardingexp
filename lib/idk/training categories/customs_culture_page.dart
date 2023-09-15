import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../task_components/task_tile.dart';
import '../../util/constants.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';

class CustomsCulturePage extends StatefulWidget {
  const CustomsCulturePage({super.key});

  @override
  State<CustomsCulturePage> createState() => _CustomsCulturePage();
}

class _CustomsCulturePage extends State<CustomsCulturePage> {
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
                  "Learn about Fiserv Customs and Culture!",
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
