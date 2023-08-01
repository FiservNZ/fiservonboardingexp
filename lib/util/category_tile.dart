import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../screens/task_categories/compliance_page.dart';
import '../screens/task_categories/week_one_page.dart';
import 'constants.dart';

class CategoryTile extends StatefulWidget {
  final String categoryName;
  final String iconName;

  const CategoryTile({
    super.key,
    required this.categoryName,
    required this.iconName,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.categoryName == "Orientation") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WeekOnePage()),
          );
        } else if (widget.categoryName == "Compliance") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecurityTasks()),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(132, 255, 255, 255),
            borderRadius: BorderRadius.circular(12.0),
            /*boxShadow: [
              BoxShadow(
                color: fiservColor.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],*/
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.categoryName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 30.0),
                child: Image.asset(
                  widget.iconName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecurityPage {}
