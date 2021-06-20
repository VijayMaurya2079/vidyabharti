import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utill {
  bool isLoading = false;

  Widget showLoader() {
    return LinearProgressIndicator(
      backgroundColor: Colors.deepOrange,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
    );
  }

  Future<bool> saveList(String key, List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, list);
  }

  Future<bool> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<List<String>> getList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> deleteLocal(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}

final utill = Utill();
