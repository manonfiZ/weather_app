import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:app_weather/screens/locations/_partials/search_result_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';

class LocationsScreenHeader extends StatelessWidget {
  const LocationsScreenHeader({
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
            onPressed: () {
              showSearch(context: context, delegate: SearchLocationDelegate());
            },
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

class SearchLocationDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    LocationModel locationModel =
        Provider.of<LocationModel>(context, listen: false);
    return SearchResultItem(locationModel: locationModel, query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    LocationModel locationModel =
        Provider.of<LocationModel>(context, listen: false);
    return SearchResultItem(locationModel: locationModel, query: query);
  }
}
