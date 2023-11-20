import 'dart:ui';

import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:app_weather/screens/home/home.dart';
import 'package:app_weather/screens/locations/_partials/add_location_button.dart';
import 'package:app_weather/screens/locations/_partials/location_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';

class MyLocations extends StatefulWidget {
  const MyLocations({super.key});

  @override
  State<MyLocations> createState() => _MyLocationsState();
}

class _MyLocationsState extends State<MyLocations> {
  String? _location;
  final _locationKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF391A49),
                    Color(0xFF301D5C),
                    Color(0xFF262171),
                    Color(0xFF301D5C),
                    Color(0xFF391A49),
                  ],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            Consumer<LocationModel>(
              builder:
                  (BuildContext context, LocationModel model, Widget? child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const ScreenHeader(),
                      ...model.locations.map((location) {
                        return GestureDetector(
                          onTap: () {
                            model.updateLocation(location);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(),
                              ),
                            );
                          },
                          child: LocationItem(location: location),
                        );
                      }),
                      NewLocationButton(
                        onTap: () => _showForm(context),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _showForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("New location"),
          content: TextFormField(
            key: _locationKey,
            onChanged: (value) {
              _location = value;
            },
            validator: (value) =>
                value!.isEmpty ? 'Name cannot be empty' : null,
            decoration: const InputDecoration(
              label: Text('Name'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_locationKey.currentState!.validate()) {
                  _addLocation(_location!);
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  _addLocation(String location) {
    LocationModel locationModel =
        Provider.of<LocationModel>(context, listen: false);

    locationModel.addNewLocation(location);
  }
}


class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Saved Locations',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              PhosphorIcons.magnifying_glass,
              color: Colors.white,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
