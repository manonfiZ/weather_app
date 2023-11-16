import 'package:app_weather/core/models/weather.dart';
import 'package:app_weather/core/viewmodel/weather_model.dart';
import 'package:app_weather/screens/home/_partials/condition_section.dart';
import 'package:app_weather/screens/home/_partials/date_section.dart';
import 'package:app_weather/screens/home/_partials/details_section.dart';
import 'package:app_weather/screens/home/_partials/header.dart';
import 'package:app_weather/screens/home/_partials/week_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchValue = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _getWeather();
  }

  @override
  Widget build(BuildContext context) {
    // _getWeather();

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
            FutureBuilder(
              future: Future.delayed(
                  const Duration(seconds: 1), () => _getWeather()),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'An error occurred',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }
                Weather weather = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const ScreenHeader()
                          .animate()
                          .moveY(duration: 800.ms, begin: -50, end: 0)
                          .fadeIn(duration: 800.ms),
                      const SizedBox(height: 20),
                      DateSection(
                        date: weather.days.first.datetime,
                        time: weather.currentConditions.datetime,
                      ).animate().fadeIn(duration: 800.ms),
                      const SizedBox(height: 30),
                      ConditionSection(
                        icon: weather.currentConditions.icon,
                        temperature: weather.currentConditions.temp,
                        condition: weather.currentConditions.conditions,
                      ).animate().fadeIn(duration: 800.ms),
                      const SizedBox(height: 30),
                      DetailSection(
                        humidity: weather.currentConditions.humidity,
                        feelsLike: weather.currentConditions.feelslike,
                        windSpeed: weather.currentConditions.windspeed,
                      ).animate().fadeIn(duration: 800.ms),
                      const SizedBox(height: 30),
                      WeekSection(daysData: weather.days.take(4).toList())
                          .animate()
                          .moveY(duration: 800.ms, begin: 50, end: 0)
                          .fadeIn(duration: 800.ms),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Weather?> _getWeather() async {
    WeatherModel weatherModel = Provider.of(context, listen: false);
    return await weatherModel.getWeather('location');
  }
}
