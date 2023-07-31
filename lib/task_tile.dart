import 'package:fiservonboardingexp/task.dart';
import 'package:flutter/material.dart';

import 'week_one_page.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final BuildContext context;
  //void Function()? onTap;
  TaskTile({
    super.key,
    required this.task,
    //required this.onTap,
    required this.context,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyTaskTileState createState() => _MyTaskTileState();
}

class _MyTaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPopup,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.brown[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(widget.task.name),
          subtitle: Text(widget.task.type),
          leading: Image.asset(widget.task.iconPath),
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
            title: Text(widget.task.name),
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
