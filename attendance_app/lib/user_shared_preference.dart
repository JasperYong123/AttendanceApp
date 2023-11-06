import 'package:shared_preferences/shared_preferences.dart';


class SharedPreference{
  
  static SharedPreferences? _preferences;

  static Future init() async =>
  _preferences = await SharedPreferences.getInstance();

  static Future setTimeFormatForSharedPref(bool timeFormat) async =>
    await _preferences?.setBool('timeAgain', timeFormat);

  static bool getTimeFormatFromSharedPref() {
  bool? temp = _preferences?.getBool('timeAgain');
  return temp ?? true; 
}

}