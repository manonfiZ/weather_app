import 'package:app_weather/configs/storage_manager.dart';
import 'package:flutter/material.dart';

class LocationModel extends ChangeNotifier {
  List<String> get locations =>
      StorageManager.preferences?.getStringList('locations') ?? [];

  String get location => StorageManager.preferences?.getString('location') ?? '';

  void updateLocation(String newLocation) async {
    await StorageManager.preferences?.setString('location', newLocation);
    notifyListeners();
  }

  void addNewLocation(String location) async {
    List<String> locations = this.locations..add(location);

    await StorageManager.preferences?.setStringList('locations', locations);
    notifyListeners();
  }

  String? search(String location) {
    return locations.firstWhere((element) => element == location,
        orElse: () => '');
  }
}
