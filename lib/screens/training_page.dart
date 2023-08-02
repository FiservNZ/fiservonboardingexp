import 'package:fiservonboardingexp/util/category_tile.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPage();
}

class _TrainingPage extends State<TrainingPage> {
  List moduleCategories = [
    // [categoryName, categoryImage]
    // Orientation (First Week), Compliance, Customs and Culture, Technical training, Health &Safety
    ["Orientation", 'assets/icon/welcome.png'],
    ["Customs & Culture", 'assets/icon/worldwide.png'],
    ["Compliance", 'assets/icon/compliance.png'],
    ["Health & Safety", 'assets/icon/guidelines.png'],
    ["Technical training", 'assets/icon/technical.png'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: myAppBar,
      backgroundColor: myBackgroundColor,
      //drawer: myDrawer,
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
                itemCount: moduleCategories.length,
                padding: const EdgeInsets.all(12.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                itemBuilder: (context, index) {
                  return CategoryTile(
                    categoryName: moduleCategories[index][0],
                    iconName: moduleCategories[index][1],
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
