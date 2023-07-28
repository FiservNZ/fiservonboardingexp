import 'package:fiserv/page/NavAppOverlay.dart';
import 'package:flutter/material.dart';
import 'page/teaser.dart';
import 'page/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Skeleton',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initScreen == 0 || initScreen == null ? 'teaser' : 'home',
      routes: {
        'home' : (context) => MyHomePage(),
        'teaser': (context) => TeaserScreen(),
      },
    );
  }
}
