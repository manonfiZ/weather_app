import 'package:app_weather/core/viewmodel/weather_model.dart';
import 'package:provider/provider.dart';

final providers = [
  ChangeNotifierProvider(create: (_) => WeatherModel()),
];
