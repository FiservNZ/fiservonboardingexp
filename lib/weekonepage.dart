import 'package:fiservonboardingexp/trainingpage.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'util/my_box.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: myAppBar,
      backgroundColor: myBackgroundColor,
      drawer: myDrawer,
      bottomNavigationBar: navBar,
      body: Column(children: [
        const SizedBox(height: 20),
        TextButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: myBackgroundColor,
          ),
          icon: Image.asset(
            'assets/Icons/back.png',
            width: 40,
            height: 40,
          ),
          label: const SizedBox.shrink(),
          // On press of the button, should be taken to trainingpage.dart
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const TrainingPage())));
          },
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Week One Page',
            textAlign: TextAlign.center,
            style: GoogleFonts.bebasNeue(fontSize: 30, color: fiservColor),
          ),
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 0.59,
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            //width: double.infinity,
            child: GridView.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.5),
              itemBuilder: (context, index) {
                String title = titles[index];
                return MyBox(title: title, context: context);
              },
            ),
          ),
        )
      ]),
    );
  }
}
