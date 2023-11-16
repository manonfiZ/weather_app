import 'package:flutter/material.dart';

class DateSection extends StatelessWidget {
  final String date;
  final String time;
  const DateSection({
    super.key,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          date,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        Text(
          'Updated as of  $time GMT-4',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
