import 'dart:async';
import 'dart:io';

import 'package:app_weather/core/services/location_service.dart';
import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:app_weather/screens/home/_partials/home_content.dart';
import 'package:app_weather/screens/locations/_partials/add_location_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool switchValue = false;
  int currentIndex = 0;

  String? _currentAddress;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCurrentPosition();
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    LocationModel locationModel = Provider.of(context, listen: true);

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
            locationModel.location != null
                ? const HomeContent()
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    LocationModel locationModel = Provider.of(context, listen: false);

    if (Platform.isAndroid || Platform.isIOS) {
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
    } else {
      // ! GeoLocator is not enabled on web, linux and macos
      if (locationModel.location == null) {
        showDialog(
            context: context, builder: (context) => const AddLocationDialog());

        // setState(() {});
      }
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    ).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      setState(() => _currentAddress = place.locality);
      LocationModel locationModel = Provider.of(context, listen: false);

      locationModel.addNewLocation(_currentAddress!);
      locationModel.updateLocation(_currentAddress!);
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
