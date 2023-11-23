import 'package:app_weather/core/models/weather.dart';
import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:app_weather/core/viewmodel/weather_model.dart';
import 'package:app_weather/screens/home/_partials/condition_section.dart';
import 'package:app_weather/screens/home/_partials/date_section.dart';
import 'package:app_weather/screens/home/_partials/details_section.dart';
import 'package:app_weather/screens/home/_partials/header.dart';
import 'package:app_weather/screens/home/_partials/week_section.dart';
import 'package:app_weather/widget/error_widget.dart';
import 'package:app_weather/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({
    super.key,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async => setState(() {}),
      child: FutureBuilder(
        future: _getWeather(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          if (snapshot.hasError || snapshot.data == null) {
            print('error => ${snapshot.error}');
            return MyErrorWidget(
              onPressed: () => setState(() {}),
            );
          }

          final Weather weather = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                ScreenHeader(
                  location: (weather.address),
                )
                    .animate()
                    .moveY(duration: 800.ms, begin: -50, end: 0)
                    .fadeIn(duration: 800.ms),
                const SizedBox(height: 20),
                DateSection(
                  date: weather.days.first.datetime,
                  time: weather.currentConditions.datetime,
                  tzoffset: weather.tzoffset,
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
                WeekSection(daysData: weather.days.take(5).toList())
                    .animate()
                    .moveY(duration: 800.ms, begin: 50, end: 0)
                    .fadeIn(duration: 800.ms),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Weather?> _getWeather() async {
    WeatherModel weatherModel = Provider.of(context, listen: false);
    LocationModel locationModel = Provider.of(context, listen: true);

    return await weatherModel.getWeather(locationModel.location ?? '');
  }
}
