import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/elle_testing/widgets/progressBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizBody extends StatelessWidget {
  const QuizBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const ProgressBar(),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    text: "Question 1",
                    style: GoogleFonts.quicksand(
                        fontSize: bodyFontSize,
                        color: const Color.fromARGB(255, 156, 156, 156)),
                    children: [
                      TextSpan(
                        text: " out of ",
                        style: GoogleFonts.quicksand(fontSize: bodyFontSize),
                      ),
                      TextSpan(
                        text: "10",
                        style: GoogleFonts.quicksand(fontSize: bodyFontSize),
                      )
                    ],
                  ),
                ),
                const Divider(thickness: 3, indent: 55, endIndent: 55),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "data blblb lblbl blblbl blblb lblbl bl blbl blbl blbl blb lbl",
                        style: darkHeaderFontStyle,
                        textAlign: TextAlign.center,
                      ),
                      //Answer_Tiles(answer: '', isSelected: null, onTap: () {  },),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
