import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

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
                    // Colors.redAccent,
                  ],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            // BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            //   child: Container(),
            // ),
            Container(
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    ScreenHeader(),
                    LocationItem(),
                    LocationItem(),
                    LocationItem(),
                    NewLocationButton()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewLocationButton extends StatelessWidget {
  const NewLocationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIcons.plus_circle,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              "Add new",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LocationItem extends StatelessWidget {
  const LocationItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        child: const Column(
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
                        'New York',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Sunny',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Icon(
                //   PhosphorIcons.cloud_sun,
                //   color: Colors.white,
                //   size: 56,
                // )
                Text(
                  '⛅',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 15,
            // ),
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
                          Text(
                            'Humidity',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '52%',
                            style: TextStyle(
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
                          Text(
                            'Wind',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '15km/h',
                            style: TextStyle(
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
                      '33',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 48,
                      ),
                    ),
                    Positioned(
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
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
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
