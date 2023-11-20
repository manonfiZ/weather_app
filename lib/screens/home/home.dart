import 'dart:async';

import 'package:app_weather/core/models/weather.dart';
import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:app_weather/core/viewmodel/weather_model.dart';
import 'package:app_weather/screens/home/_partials/condition_section.dart';
import 'package:app_weather/screens/home/_partials/date_section.dart';
import 'package:app_weather/screens/home/_partials/details_section.dart';
import 'package:app_weather/screens/home/_partials/header.dart';
import 'package:app_weather/screens/home/_partials/week_section.dart';
import 'package:app_weather/services/location_service.dart';
import 'package:app_weather/widget/error_widget.dart';
import 'package:app_weather/widget/loading_widget.dart';
import 'package:app_weather/widget/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchValue = false;
  int currentIndex = 0;

  String? _currentAddress;
  bool _isConnected = false;
  StreamSubscription<InternetConnectionStatus>? listener;

  @override
  void initState() {
    super.initState();

    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('Data connection is available.');
          _isConnected = true;
          break;
        case InternetConnectionStatus.disconnected:
          _isConnected = false;
          _showMessage();
          print('You are disconnected from the internet.');
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    listener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print("----------------> ${_isConnected}");
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              // color: Colors.red,
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
            !_isConnected
                ? const NoInternetWidget()
                : FutureBuilder(
                    future: _init(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      }

                      if (snapshot.hasError) {
                        return  const MyErrorWidget();
                      }

                      Weather weather = snapshot.data;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ScreenHeader(
                              location: weather.address,
                            )
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

  _showMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.orange,
        content: Text('No internet connection'),
      ),
    );
  }

  Future<Weather?> _init() async {
    await _getCurrentPosition();
    return await _getWeather();
  }

  Future<Weather?> _getWeather() async {
    WeatherModel weatherModel = Provider.of(context, listen: false);
    LocationModel locationModel = Provider.of(context, listen: false);

    return await weatherModel.getWeather(locationModel.location);
  }

  Future<void> _getCurrentPosition() async {
    LocationModel locationModel = Provider.of(context, listen: false);

    if (locationModel.locations.isEmpty) {
      final hasPermission =
          await LocationService.handleLocationPermission(context);

      if (!hasPermission) return;

      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        _getAddressFromLatLng(position);
      }).catchError((e) {
        debugPrint(e);
      });
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    ).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      // print('=====> ${place.toJson()}');
      setState(() => _currentAddress = place.locality);
      LocationModel locationModel = Provider.of(context, listen: false);

      locationModel.addNewLocation(_currentAddress!);
      locationModel.updateLocation(_currentAddress!);
    }).catchError((e) {
      debugPrint(e);
    });
  }
}


