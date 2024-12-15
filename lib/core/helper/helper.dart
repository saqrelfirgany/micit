import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:micit/core/router/route_names.dart';
import 'package:micit/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/login_feature/data/models/user_model.dart';

class Helper {
  static String token = '';
  static String deviceToken = 'Helper.deviceToken';
  static bool isLoggedIn = false;
  static String lang = 'en';

  static String userLoggedKey = 'IsLoggedIn';
  static String userTokenKey = 'UserToken';
  static String userLangKey = 'userLang';
  static String userModelKey = 'userModel';

  /// Save User Logged
  static Future<bool> saveUserLogged(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setBool(userLoggedKey, isLoggedIn);
  }

  /// Get User Logged
  static getUserLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(userLoggedKey) ?? false;
  }

  /// Save User Token
  static Future<bool> saveUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(userTokenKey, token);
  }

  /// Get User Token
  static getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(userTokenKey) ?? '';
  }

  /// Save User Lang
  static Future<bool> saveUserLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(userLangKey, lang);
  }

  /// Get User Lang
  static getUserLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(userLangKey) ?? '';
  }

  /// Save User Model
  static Future<bool> saveUserModel({required UserModel userModel}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = json.encode(userModel.toJson());
    return await prefs.setString(userModelKey, userJson);
  }

  /// Get User Model
  static getUserModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(userModelKey);
    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return UserModel.fromJson(userMap);
    } else {
      Helper.isLoggedIn = false;
      await Helper.saveUserLogged(false);
      navigatorKey.currentState!.context.go(AppRouteName.loginScreenRoute);
    }
    return null;
  }

  static Future removeUserModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Helper.isLoggedIn = false;
    await Helper.saveUserLogged(false);
    navigatorKey.currentState!.context.go(AppRouteName.loginScreenRoute);

    return await prefs.remove(userModelKey);
  }
}
