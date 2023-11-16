// To parse this JSON data, do
//
//     final weather = weatherFromJson(jsonString);

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));


class Weather {
  String latitude;
  String longitude;
  String resolvedAddress;
  String address;
  String timezone;
  String description;
  List<CurrentConditions> days;
  CurrentConditions currentConditions;

  Weather({
    required this.latitude,
    required this.longitude,
    required this.resolvedAddress,
    required this.address,
    required this.timezone,
    required this.description,
    required this.days,
    required this.currentConditions,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        latitude: json["latitude"].toString(),
        longitude: json["longitude"].toString(),
        resolvedAddress: json["resolvedAddress"],
        address: json["address"],
        timezone: json["timezone"],
        description: json["description"],
        days: List<CurrentConditions>.from(
            json["days"].map((x) => CurrentConditions.fromJson(x))),
        currentConditions:
            CurrentConditions.fromJson(json["currentConditions"]),
      );

}

class CurrentConditions {
  String datetime;
  String temp;
  String feelslike;
  String humidity;
  String windspeed;
  String windgust;
  String conditions;
  String icon;
  String? description;
  final List<CurrentConditions>? hours;

  CurrentConditions({
    required this.datetime,
    required this.temp,
    required this.feelslike,
    required this.humidity,
    required this.windspeed,
    required this.windgust,
    required this.conditions,
    required this.icon,
    required this.hours,
    this.description,
  });

  factory CurrentConditions.fromJson(Map<String, dynamic> json) =>
      CurrentConditions(
        datetime: json["datetime"],
        temp: json["temp"].toString(),
        feelslike: json["feelslike"].toString(),
        humidity: json["humidity"].toString(),
        windspeed: json["windspeed"].toString(),
        windgust: json["windgust"].toString(),
        conditions: json["conditions"],
        icon: json["icon"],
        description: json["description"],
        hours: json["hours"] == null
            ? []
            : List<CurrentConditions>.from(
                json["hours"]!.map((x) => CurrentConditions.fromJson(x))),
      );

}
