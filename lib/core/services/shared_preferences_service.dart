import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late SharedPreferences prefs;

  Future<void> setData<T>(String key, T value) async {
    prefs = await SharedPreferences.getInstance();

    if (T == String) {
      await prefs.setString(key, value as String);
    } else if (T == int) {
      await prefs.setInt(key, value as int);
    } else if (T == double) {
      await prefs.setDouble(key, value as double);
    } else if (T == bool) {
      await prefs.setBool(key, value as bool);
    }
  }

  Future<T?> getData<T>(String key) async {
    prefs = await SharedPreferences.getInstance();

    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else {
      return null;
    }
  }

  Future<void> removeData(String key) async {
    prefs = await SharedPreferences.getInstance();

    await prefs.remove(key);
  }

  //will be used for logout
  Future<void> clearData() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
