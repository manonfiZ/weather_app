import 'package:app_weather/core/models/weather.dart';
import 'package:app_weather/utils/constants.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  static Future<Weather?> fetchWeather(String location) async {
    final url = Uri.parse(Constant.url.replaceFirst('__locality__', location));
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return weatherFromJson(response.body);
    }

    return null;
  }
}
