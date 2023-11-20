import 'package:app_weather/core/models/weather.dart';
import 'package:app_weather/core/viewmodel/weather_model.dart';
import 'package:app_weather/widget/error_widget.dart';
import 'package:app_weather/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationItem extends StatefulWidget {
  final String location;
  const LocationItem({
    super.key,
    required this.location,
  });

  @override
  State<LocationItem> createState() => _LocationItemState();
}

class _LocationItemState extends State<LocationItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getWeather(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          if (snapshot.hasError) {
            return const MyErrorWidget();
          }

          Weather weather = snapshot.data;

          return Container(
            // color: Colors.blue,
            padding: const EdgeInsets.all(5),
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.location,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              weather.currentConditions.conditions,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                          'assets/icons/${weather.currentConditions.icon}.png'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Humidity',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  weather.currentConditions.humidity,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  'Wind',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  ' ${weather.currentConditions.windspeed}km/h',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Text(
                            weather.currentConditions.temp,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 48,
                            ),
                          ),
                          const Positioned(
                            right: -30,
                            top: 0,
                            child: Text(
                              '°C',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<Weather?> _getWeather() async {
    WeatherModel weatherModel = Provider.of(context, listen: false);
    // LocationModel locationModel = Provider.of(context, listen: false);

    return await weatherModel.getWeather(widget.location);
  }
}

