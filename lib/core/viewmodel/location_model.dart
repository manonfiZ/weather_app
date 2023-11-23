import 'package:app_weather/core/configs/storage_manager.dart';
import 'package:app_weather/core/repositories/location_repository.dart';
import 'package:flutter/material.dart';

class LocationModel extends ChangeNotifier {
  List<String> get locations =>
      StorageManager.preferences?.getStringList('locations') ?? [];

  String? get location => StorageManager.preferences?.getString('location');

  Future<void> updateLocation(String newLocation) async {
    await StorageManager.preferences?.setString('location', newLocation);
    notifyListeners();
  }

  Future<void> addNewLocation(String location) async {
    List<String> locations = this.locations..add(location);

    await StorageManager.preferences?.setStringList('locations', locations);
    notifyListeners();
  }

  List<String> search(String location) {
    var r = locations
        .where(
            (element) => element.toLowerCase().contains(location.toLowerCase()))
        .toList();

    return r;
  }

  Future<String?> getLocationImage(String location) async {
    try {
      return await LocationRepository.fetchLocationImage(location);
    } catch (e) {
      debugPrint('Error ---------> ${e.toString()}');
      return null;
    }
  }
}
