import 'package:fiservonboardingexp/widgets/exp_bar.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'app_bar_overlay.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ExpBar _expBar = const ExpBar(Barwidth: 150);

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // //appbar
        appBar: const AppBarOverlay(),
        bottomNavigationBar: const CustomNavBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigation),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () {
            int expToAdd = 10;
            print("add");
            _expBar.addExperience(expToAdd);
            // _expBar.addExperience(expToAdd);
          },
        ),
        //Home Page
        body: Scrollbar(
            thumbVisibility: true,
            child: ListView(
              children: [
                //expBar
                Container(
                  alignment: Alignment.centerLeft,
                  child: const ExpBar(
                    Barwidth: 150,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  color: Colors.white,
                  height: 300,
                  child: const Text('Please Scroll Down',
                      style: TextStyle(color: Color(0xFFFF6600))),
                ),
                Container(
                  color: Colors.white,
                  height: 200,
                  child: const Image(
                      image: AssetImage('assets/images/Fiserv_logo.png')),
                ),
                Container(
                  color: Colors.white,
                  height: 300,
                ),
                Container(
                  color: Colors.white,
                  height: 200,
                  child: const Image(
                      image: AssetImage('assets/images/Fiserv_logo.png')),
                ),
                Container(
                  color: Colors.white,
                  height: 300,
                ),
                Container(
                  color: Colors.white,
                  height: 200,
                  child: const Image(
                      image: AssetImage('assets/images/Fiserv_logo.png')),
                )
              ],
            )),
      ),
    );
  }
}
