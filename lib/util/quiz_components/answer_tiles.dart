import 'package:flutter/material.dart';

import '../constants.dart';

class Answer_Tiles extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const Answer_Tiles({
    super.key,
    required this.answer,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onTap,
      child: Ink(
        child: Text(
          answer,
          style: TextStyle(color: isSelected ? Colors.purple : darkTileColor),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: isSelected ? Colors.blue : Colors.amber),
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: darkTileColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }*/
}
