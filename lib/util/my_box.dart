import 'package:fiservonboardingexp/task.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/week_one_page.dart';
import 'package:flutter/material.dart';

class MyBox extends StatefulWidget {
  final String title;
  final BuildContext context;
  //final Task task;

  const MyBox({
    Key? key,
    required this.title,
    required this.context,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyBoxState createState() => _MyBoxState();
}

class _MyBoxState extends State<MyBox> {
  bool showTitle = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const WeekOnePage())));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 209, 208, 208),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: fiservColor.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPopup() {
    showDialog(
      context: widget.context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            // Customize the background color of the AlertDialog here
            dialogBackgroundColor: Colors.white,
            // Customize the shape of the AlertDialog here (optional)
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            title: Text(widget.title),
            content: const Text('Popup Content'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // On press of the button, the pop up window should close
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  // On press of the button, should be taken to weekonepage.dart
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    icon: Image.asset(
                      'assets/icon/start-button.png',
                      width: 60,
                      height: 60,
                    ),
                    label: const SizedBox.shrink(),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const WeekOnePage())));
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
