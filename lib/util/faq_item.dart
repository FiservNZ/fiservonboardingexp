import 'package:flutter/material.dart';

class FaqItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const FaqItem({required this.data});

  @override
  Widget build(BuildContext context) {
    final List<ExpansionTile> fieldExpansionTiles = [];

    data.forEach((question, answer) {
      final fieldExpansionTile = ExpansionTile(
        title: Text(question),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(answer.toString()),
          ),
        ],
      );
      fieldExpansionTiles.add(fieldExpansionTile);
    });

    return Column(
      children: fieldExpansionTiles,
    );
  }
}
