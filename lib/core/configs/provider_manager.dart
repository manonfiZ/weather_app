import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:app_weather/core/viewmodel/weather_model.dart';
import 'package:provider/provider.dart';

final providers = [
  ChangeNotifierProvider(create: (_) => WeatherModel()),
  ChangeNotifierProvider(create: (_) => LocationModel()),
];
