import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:app_weather/screens/home/home.dart';
import 'package:flutter/material.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({
    super.key,
    required this.locationModel,
    required this.query,
  });

  final LocationModel locationModel;
  final String query;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            locationModel.updateLocation(locationModel.search(query)[index]);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MyHomePage(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: ListTile(
              title: Text(locationModel.search(query)[index]),
            ),
          ),
        );
      },
      itemCount: locationModel.search(query).length,
    );
  }
}
