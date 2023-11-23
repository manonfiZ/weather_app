import 'dart:async';
import 'dart:io';

import 'package:app_weather/core/services/location_service.dart';
import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:app_weather/screens/home/_partials/home_content.dart';
import 'package:app_weather/screens/locations/_partials/add_location_dialog.dart';
import 'package:app_weather/screens/locations/locations.dart';
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
  String? _image;

  String? _currentAddress;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
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
              child: _image != null
                  ? Image.network(
                      _image!,
                      alignment: Alignment.center,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                    )
                  : Image.asset(
                      'assets/images/london.png',
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              color: Colors.black.withOpacity(.5),
            ),
            locationModel.location != null
                ? const HomeContent()
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'No location saved, please add new one by clicking on the button bellow.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontSize,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyLocations(),
                                ),
                              );
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Go to locations'),
                                Icon(
                                  Icons.arrow_right,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _init() async {
    await _getCurrentPosition();
    await _fetchImage();
  }

  Future<String?> _fetchImage() async {
    LocationModel locationModel = Provider.of(context, listen: false);

    if (locationModel.location == null) return null;

    String? image =
        await locationModel.getLocationImage(locationModel.location!);

    setState(() {
      _image = image;
    });

    return image;
  }

  Future<void> _getCurrentPosition() async {
    LocationModel locationModel = Provider.of(context, listen: false);

    if (Platform.isAndroid || Platform.isIOS) {
      if (locationModel.locations.isEmpty) {
        final hasPermission =
            await LocationService.handleLocationPermission(context);

        if (!hasPermission) {
          // * Show dialog for user to add new location
          _showNewLocationDialog();
          return;
        }

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
        // * Show dialog for user to add new location
        _showNewLocationDialog();
        return;
      }
    }
  }

  _showNewLocationDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const AddLocationDialog());
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
