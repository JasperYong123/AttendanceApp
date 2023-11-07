// ignore_for_file: prefer_const_declarations

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class SharedPreference{
  
  static SharedPreferences? _preferences;
  static final listKey = 'myListKey';

  static Future init() async =>
  _preferences = await SharedPreferences.getInstance();

  static Future setTimeFormatForSharedPref(bool timeFormat) async =>
    await _preferences?.setBool('timeAgain', timeFormat);


  static Future saveListToSharedPref(List myList) async{
    // final List<String> encodedList = myList.map((map) => json.encode(map)).toList();
    final List<String> encodedList = myList.map((map) {

    map['check-in'] = map['check-in'].toString();
    return json.encode(map);
  }).toList();
    await _preferences?.setStringList(listKey, encodedList);

  }  

  static bool getTimeFormatFromSharedPref() {
  bool? temp = _preferences?.getBool('timeAgain');
  return temp ?? true; 
}
static List getListFromSharedPreferences() {
  List<String>? encodedList = _preferences?.getStringList(listKey);

  if (encodedList == null) {
    return []; // Return an empty list if the data doesn't exist
  }

  List decodedList = [];
  decodedList = encodedList.map((String map) {
    final decodedMap = json.decode(map);
    // Parse 'check-in' back to DateTime
    decodedMap['check-in'] = DateTime.parse(decodedMap['check-in']);
    return decodedMap;
  }).toList();

  return decodedList;
}
  static Future setFirstLoginSharedPref(bool login) async =>
    await _preferences?.setBool('login', login);

  static bool getFirstLoginFromSharedPref() {
  bool? temp = _preferences?.getBool('login');
  return temp ?? true; 
}

}