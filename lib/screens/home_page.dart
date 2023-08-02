import 'package:fiservonboardingexp/screens/nav_bar.dart';

import 'app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // //appbar
        appBar: const AppBarOverlay(),
        bottomNavigationBar: customNavBar(),
        //Home Page
        body: Scrollbar(
            thumbVisibility: true,
            child: ListView(
              children: [
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
