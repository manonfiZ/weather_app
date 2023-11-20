import 'package:app_weather/core/models/weather.dart';
import 'package:app_weather/core/viewmodel/weather_model.dart';
import 'package:app_weather/screens/home/_partials/condition_section.dart';
import 'package:app_weather/screens/home/_partials/date_section.dart';
import 'package:app_weather/screens/home/_partials/details_section.dart';
import 'package:app_weather/screens/home/_partials/header.dart';
import 'package:app_weather/screens/home/_partials/week_section.dart';
import 'package:app_weather/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchValue = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _getWeather();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    // _getWeather();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.red,
              child: Image.asset(
                'assets/images/london.png',
                alignment: Alignment.center,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(.5),
            ),
            FutureBuilder(
              future: _getWeather(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'An error occurred',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }
                Weather weather = snapshot.data;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                       ScreenHeader(location: weather.address,)
                          .animate()
                          .moveY(duration: 800.ms, begin: -50, end: 0)
                          .fadeIn(duration: 800.ms),
                      const SizedBox(height: 20),
                      DateSection(
                        date: weather.days.first.datetime,
                        time: weather.currentConditions.datetime,
                        tzoffset: weather.tzoffset,
                      ).animate().fadeIn(duration: 800.ms),
                      const SizedBox(height: 30),
                      ConditionSection(
                        icon: weather.currentConditions.icon,
                        temperature: weather.currentConditions.temp,
                        condition: weather.currentConditions.conditions,
                      ).animate().fadeIn(duration: 800.ms),
                      const SizedBox(height: 30),
                      DetailSection(
                        humidity: weather.currentConditions.humidity,
                        feelsLike: weather.currentConditions.feelslike,
                        windSpeed: weather.currentConditions.windspeed,
                      ).animate().fadeIn(duration: 800.ms),
                      const SizedBox(height: 30),
                      WeekSection(daysData: weather.days.take(5).toList())
                          .animate()
                          .moveY(duration: 800.ms, begin: 50, end: 0)
                          .fadeIn(duration: 800.ms),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Weather?> _getWeather() async {
    WeatherModel weatherModel = Provider.of(context, listen: false);
    return await weatherModel.getWeather('location');
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission =
        await LocationService.handleLocationPermission(context);

    if (!hasPermission) return;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      print('========> ${position.toJson()}');
      _getAddressFromLatLng(position);
      // setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    ).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      print('=====> ${place.toJson()}');
      // setState(() {
      //   _currentAddress =
      //      '${place.street}, ${place.subLocality},
      //       ${place.subAdministrativeArea}, ${place.postalCode}';
      // });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
