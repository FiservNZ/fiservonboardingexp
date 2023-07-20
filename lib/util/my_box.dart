import 'package:fiservonboardingexp/constants.dart';
import 'package:flutter/material.dart';

class MyBox extends StatefulWidget {
  final String title;
  final BuildContext context;

  const MyBox({Key? key, required this.title, required this.context})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyBoxState createState() => _MyBoxState();
}

class _MyBoxState extends State<MyBox> {
  bool showTitle = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPopup,
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
        return AlertDialog(
          title: Text(widget.title),
          content: const Text('Popup Content'),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
