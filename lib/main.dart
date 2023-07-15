import 'package:fiserv/page/colleagues_page.dart';
import 'package:flutter/material.dart';
import 'page/home_page.dart';
import 'page/modules_page.dart';
import 'page/urgent_tasks_page.dart';
import 'page/achievements_page.dart';
import 'package:flutter/material.dart';
import 'page/teaser.dart';

void main() {
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
      // home: MyHomePage(),
      home: TeaserScreen(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Color(0xFFFF6600),
      ),
      body: Center(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const ModulesPage(),
    const UrgentTasksPage(),
    const AchievementsPage(),
    const ColleaguesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rank Name'),
        elevation: 0,
        backgroundColor: const Color(0xFFFF6600),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/userIcon.png'),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.help_outline, size: 30),
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Color(0xFFFF6600),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            backgroundColor: Color(0xFFFF6600),
            label: 'Modules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            backgroundColor: Color(0xFFFF6600),
            label: 'Urgent Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            backgroundColor: Color(0xFFFF6600),
            label: 'Achievements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search_outlined),
            backgroundColor: Color(0xFFFF6600),
            label: 'Colleagues',
          ),
        ],
      ),
    );
  }
}