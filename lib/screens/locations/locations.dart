import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:app_weather/screens/home/home.dart';
import 'package:app_weather/screens/locations/_partials/add_location_button.dart';
import 'package:app_weather/screens/locations/_partials/add_location_dialog.dart';
import 'package:app_weather/screens/locations/_partials/location_item.dart';
import 'package:app_weather/screens/locations/_partials/locations_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLocations extends StatefulWidget {
  const MyLocations({super.key});

  @override
  State<MyLocations> createState() => _MyLocationsState();
}

class _MyLocationsState extends State<MyLocations> {
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
                      const LocationsScreenHeader(),
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
        return const AddLocationDialog();
      },
    );
  }
}
