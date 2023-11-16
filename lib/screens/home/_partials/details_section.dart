import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class DetailSection extends StatelessWidget {
  final String humidity;
  final String feelsLike;
  final String windSpeed;
  const DetailSection({
    super.key,
    required this.humidity,
    required this.feelsLike,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DetailItem(
          icon: PhosphorIcons.drop,
          title: 'Humidity',
          value: '$humidity%',
        ),
        DetailItem(
          icon: PhosphorIcons.wind,
          title: 'Wind',
          value: '$windSpeed km/h',
        ),
        DetailItem(
          icon: PhosphorIcons.thermometer,
          title: 'Feel like',
          value: '$feelsLike°',
        ),
      ],
    );
  }
}

class DetailItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DetailItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

