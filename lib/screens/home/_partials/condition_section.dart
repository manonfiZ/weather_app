import 'package:flutter/material.dart';

class ConditionSection extends StatelessWidget {
  final String icon;
  final String condition;
  final String temperature;
  const ConditionSection({
    super.key,
    required this.icon,
    required this.condition,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset('assets/icons/$icon.png'),
      Text(
        condition,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 40,
        ),
      ),
      Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Text(
            temperature,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 86,
            ),
          ),
          const Positioned(
            right: -30,
            top: 25,
            child: Text(
              '°C',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ],
      )
    ]);
  }
}

