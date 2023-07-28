import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String text;
  final String fieldName;
  final void Function()? onPressed;
  const CustomTextBox({
    super.key,
    required this.text,
    required this.fieldName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                fieldName,
                style: const TextStyle(
                  color: Color(0xFFFF6600),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.edit),
                color: const Color(0xFFFF6600),
              ),
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}
