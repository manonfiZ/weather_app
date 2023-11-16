
import 'package:app_weather/screens/locations.dart';
import 'package:flutter/material.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyLocations(),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.place,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'New York',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
