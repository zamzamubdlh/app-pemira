import 'dart:convert';
import 'package:pemira_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  static Future<UserModel?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString('user');

    if (userString == null) return null;

    var userMap = jsonDecode(userString);

    return UserModel.fromJson(userMap);
  }

  static Future<bool> setUser(Map userMap) async {
    final pref = await SharedPreferences.getInstance();
    String userString = jsonEncode(userMap);
    bool success = await pref.setString('user', userString);

    return success;
  }

  static Future<bool> removeUser() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('user');

    return success;
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    return token;
  }

  static Future<bool> setToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.setString('token', token);

    return success;
  }

  static Future<bool> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('token');

    return success;
  }

  static Future<bool> setId(int id) async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.setInt('id', id);

    return success;
  }

  static Future<int?> getId() async {
    final pref = await SharedPreferences.getInstance();
    int? id = pref.getInt('it');

    return id;
  }
}
