import 'dart:async';

import 'package:app_weather/core/models/weather.dart';
import 'package:app_weather/core/repositories/weather_repository.dart';
import 'package:flutter/material.dart';

class WeatherModel extends ChangeNotifier {
  Future<Weather?> getWeather(String location) async {
    try {
      return await WeatherRepository.fetchWeather(location);
    } catch (e) {
      debugPrint('Error ---------> ${e.toString()}');
      return null;
    }
  }
}
