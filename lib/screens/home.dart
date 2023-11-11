import 'package:app_weather/screens/locations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchValue = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.red,
              child: Image.asset(
                'assets/images/london.png',
                alignment: Alignment.center,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(.33),
            ),
            Container(
              // color: Colors.blue,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    ScreenHeader(),
                    SizedBox(height: 20),
                    DateSection(),
                    SizedBox(height: 30),
                    ConditionSection(),
                    SizedBox(height: 30),
                    DetailSection(),
                    SizedBox(height: 30),
                    WeekSection()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekSection extends StatelessWidget {
  const WeekSection({
    super.key,
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: WeekItem(
              icon: PhosphorIcons.sun_light,
              day: "Wed 16",
              temperature: '22°',
              wind: "1-5",
              textIcon: '🌤️',
            ),
          ),
          Expanded(
            child: WeekItem(
              icon: PhosphorIcons.cloud_sun,
              day: "Thu 17",
              temperature: '25°',
              wind: "1-5",
              textIcon: '🌦️',
            ),
          ),
          Expanded(
            child: WeekItem(
              icon: PhosphorIcons.sun_horizon,
              day: "Fri 18",
              temperature: '23°',
              wind: "5-10",
              textIcon: '🌤️',
            ),
          ),
          Expanded(
            child: WeekItem(
              icon: PhosphorIcons.cloud,
              day: "Sat 19",
              temperature: '25°',
              wind: "1-5",
              textIcon: '🌤️',
            ),
          ),
        ],
      ),
    );
  }
}

class WeekItem extends StatelessWidget {
  final String day;
  final String temperature;
  final String wind;
  final IconData icon;
  final String? textIcon;

  const WeekItem({
    super.key,
    required this.icon,
    required this.day,
    required this.temperature,
    required this.wind,
    this.textIcon,
  });

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
          // Icon(
          //   icon,
          //   color: Colors.white,
          //   size: 30,
          // ),
          Text(
            '$textIcon',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
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

class DetailSection extends StatelessWidget {
  const DetailSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DetailItem(
            icon: PhosphorIcons.rainbow_cloud,
            title: 'Humidity',
            value: '52%',
          ),
          DetailItem(
            icon: PhosphorIcons.wind,
            title: 'Wind',
            value: '15km/h',
          ),
          DetailItem(
            icon: PhosphorIcons.thermometer,
            title: 'Feel like',
            value: '12°',
          ),
        ],
      ),
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
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ConditionSection extends StatelessWidget {
  const ConditionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(children: [
        // Icon(
        //   PhosphorIcons.cloud_sun,
        //   size: 50,
        //   color: Colors.white,
        // ),
        Text(
          '🌤️',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        Text(
          'Sunny',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Text(
              '33',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 86,
              ),
            ),
            Positioned(
              right: -30,
              top: 25,
              child: Text(
                '°C',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}

class DateSection extends StatelessWidget {
  const DateSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'June 10',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        Text(
          'Updated as of 10:09 PM GMT-4',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyLocations(),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.place,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'New York',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
