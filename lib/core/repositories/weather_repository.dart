
import 'package:app_weather/core/models/weather.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;


class WeatherRepository {


  static Future<Weather?> fetchWeather(String location) async {
    // final url = Uri.parse('file:///home/manonfi/Downloads/today.json');

    // final http.Response response = await http.get(url);

    // if (response.statusCode == 200) {
    //   return Weather.fromJson(response.body as Map<String, dynamic>);
    // }

    // return null;

      var data = await rootBundle.loadString('assets/data/data.json');

    return weatherFromJson(data);
  }
}
