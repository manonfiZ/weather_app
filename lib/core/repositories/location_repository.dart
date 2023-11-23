import 'dart:convert';

import 'package:app_weather/utils/constants.dart';
import 'package:http/http.dart' as http;

class LocationRepository {
  static Future<String?> fetchLocationImage(String location) async {
    final url =
        Uri.parse(Constant.imageUrl.replaceFirst('__location__', location));
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['hits'] as List<dynamic>;

      if (data.isEmpty) {
        return null;
      }

      return data[0]['largeImageURL'];
    }

    return null;
  }
}
