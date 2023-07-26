import 'package:flutter/material.dart';
import 'package:fiservonboardingexp/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFFF6600),
          leading: IconButton(
            icon: const Image(image: AssetImage('images/profile.png')),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          title: const Center(
            child: Text("[Rank Title]"),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
            ),
          ]),
      body: const Center(
        child: Image(image: AssetImage('images/Fiserv_logo.png')),
      ),
    );
  }
}
