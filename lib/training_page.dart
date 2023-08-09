import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/my_box.dart';
import 'package:fiservonboardingexp/week_one_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPage();
}

class _TrainingPage extends State<TrainingPage> {
  bool showTitle = false;
  List<String> titles = [
    'Title 1',
    'Title 2',
    'Title 3',
    'Title 4',
    'Title 5',
    'Title 6'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: myAppBar,
      backgroundColor: myBackgroundColor,
      drawer: myDrawer,
      //bottomNavigationBar: navBar,
      body: Column(
        children: [
          const SizedBox(height: 15),
          Text('My Training',
              style: GoogleFonts.bebasNeue(fontSize: 30, color: fiservColor)),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 0.573,
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              //width: double.infinity,
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                itemBuilder: (context, index) {
                  String title = titles[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the new page when the box is tapped.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WeekOnePage()),
                      );
                    },
                    child: MyBox(
                      title: title,
                      context: context,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
