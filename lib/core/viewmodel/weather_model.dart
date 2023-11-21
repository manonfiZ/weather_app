import 'dart:async';

import 'package:app_weather/core/models/weather.dart';
import 'package:app_weather/core/repositories/weather_repository.dart';
import 'package:flutter/material.dart';

class WeatherModel extends ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  bool _hasError = false;

  bool get hasError => _hasError;

  bool get isLoading => _isLoading;

  Weather? get weather => _weather;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  Future<Weather?> getWeather(String location) async {
    setLoading(true);
    try {
      _weather = await WeatherRepository.fetchWeather(location);
      setLoading(false);

      return weather;
    } catch (e) {
      setLoading(false);
      setError(true);

      debugPrint('Error ---------> ${e.toString()}');
      rethrow;
    }
  }
}
