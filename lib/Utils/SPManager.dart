import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SPManager {
  final String authToken = "authToken";
 

  Future<void> clear() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getKeys();
    for (String key in pref.getKeys()) {
      // if (key == "authToken") {
      pref.remove(key);
      // }
    }
    //pref.clear();
  }
  Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  //set auth token into shared preferences
/*  Future<void> setAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.authToken, token);
  }

  //get auth token into shared preferences
  Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? val;
    val = (prefs.getString(this.authToken) ?? "");
    return val;
  }*/

  Future<void> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> setUserData(String userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', userData);
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('user_data');
    return data != null ? json.decode(data) : {};
  }

  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
    // Add any other auth-related data you need to clear
  }
}
