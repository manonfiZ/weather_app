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

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.weatherModel,
    required this.onRefresh,
  });

  final WeatherModel weatherModel;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      child: weatherModel.isLoading
          ? const LoadingWidget()
          : weatherModel.hasError
              ? MyErrorWidget(onPressed: () => onRefresh())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ScreenHeader(
                        location: weatherModel.weather!.address,
                      )
                          .animate()
                          .moveY(duration: 800.ms, begin: -50, end: 0)
                          .fadeIn(duration: 800.ms),
                      const SizedBox(height: 20),
                      DateSection(
                        date: weatherModel.weather!.days.first.datetime,
                        time: weatherModel.weather!.currentConditions.datetime,
                        tzoffset: weatherModel.weather!.tzoffset,
                      ).animate().fadeIn(duration: 800.ms),
                      const SizedBox(height: 30),
                      ConditionSection(
                        icon: weatherModel.weather!.currentConditions.icon,
                        temperature:
                            weatherModel.weather!.currentConditions.temp,
                        condition:
                            weatherModel.weather!.currentConditions.conditions,
                      ).animate().fadeIn(duration: 800.ms),
                      const SizedBox(height: 30),
                      DetailSection(
                        humidity:
                            weatherModel.weather!.currentConditions.humidity,
                        feelsLike:
                            weatherModel.weather!.currentConditions.feelslike,
                        windSpeed:
                            weatherModel.weather!.currentConditions.windspeed,
                      ).animate().fadeIn(duration: 800.ms),
                      const SizedBox(height: 30),
                      WeekSection(
                              daysData:
                                  weatherModel.weather!.days.take(5).toList())
                          .animate()
                          .moveY(duration: 800.ms, begin: 50, end: 0)
                          .fadeIn(duration: 800.ms),
                    ],
                  ),
                ),
    );
  }
}
