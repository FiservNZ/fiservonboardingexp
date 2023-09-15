import 'package:flutter/material.dart';
import 'training categories/compliance_page.dart';
import 'training categories/customs_culture_page.dart';
import 'training categories/health_and_safety_page.dart';
import 'training categories/technical_training_page.dart';
import 'training categories/week_one_page.dart';

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
            MaterialPageRoute(builder: (context) => const WeekOnePage()),
          );
        } else if (widget.categoryName == "Compliance") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecurityTasks()),
          );
        } else if (widget.categoryName == "Health & Safety") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HnSTasks()),
          );
        } else if (widget.categoryName == "Technical training") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TechnicalTasks()),
          );
        } else if (widget.categoryName == "Customs & Culture") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CustomsCulturePage()),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(132, 90, 89, 89),
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
