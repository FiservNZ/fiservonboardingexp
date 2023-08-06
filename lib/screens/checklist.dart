import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class CheckList extends StatelessWidget {
  const CheckList({Key? key}) : super(key: key);

  createAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Daily Checklist"),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Exit"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Container(
            child: Center(
              child: TextButton(
                onPressed: () {
                  createAlertDialog(context);
                },
                child: Icon(
                  Icons.check_box,
                  size: 32.0,
                  color: FiservColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
