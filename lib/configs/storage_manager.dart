import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static SharedPreferences? preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }
}
