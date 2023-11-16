
import 'package:app_weather/core/models/weather.dart';
import 'package:flutter/material.dart';

class WeekSection extends StatelessWidget {
  final List<CurrentConditions> daysData;

  const WeekSection({
    super.key,
    required this.daysData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF535353),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...daysData.map(
            (data) => Expanded(
              child: WeekItem(
                icon: data.icon,
                day: data.datetime,
                temperature: data.temp,
                wind: '${data.windspeed} - ${data.windgust}',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WeekItem extends StatelessWidget {
  final String day;
  final String temperature;
  final String wind;
  final String icon;

  const WeekItem(
      {super.key,
      required this.icon,
      required this.day,
      required this.temperature,
      required this.wind});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Image.asset('assets/icons/$icon.png'),
          Text(
            temperature,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            wind,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const Text(
            'km/h',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

