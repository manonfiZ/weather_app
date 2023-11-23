import 'package:app_weather/utils/utils.dart';
import 'package:flutter/material.dart';

class DateSection extends StatelessWidget {
  final String date;
  final String time;
  final double tzoffset;
  const DateSection({
    super.key,
    required this.time,
    required this.date,
    required this.tzoffset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          MyDateUtils.formatStringDate(date),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        Text(
          'Updated as of  $time GMT ${_formatTZ(tzoffset)}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _formatTZ(double value) {
    return '${value >= 0 ? "+" : ''} ${value.toStringAsFixed(0)}';
  }
}
