import 'dart:async';

import 'package:app_weather/core/models/weather.dart';
import 'package:app_weather/core/repositories/weather_repository.dart';
import 'package:flutter/material.dart';


class WeatherModel extends ChangeNotifier {

  Future<Weather?> getWeather(String location) async {
    try {

      Weather?  weather = await WeatherRepository.fetchWeather(location);

      return weather;
      
    } catch (e) {

      debugPrint('Error ---------> ${e.toString()}');
      rethrow;
    }
  }
}
