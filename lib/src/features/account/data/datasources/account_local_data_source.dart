import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_information_model.dart';

abstract class AccountLocalDataSource {
  Future<UserInformationModel?> getUser(String userId);

  Future<void> addUser(UserInformationModel user);
}

class AccountSharedPreferencesImpl implements AccountLocalDataSource {
  String _key(String userId) => "${userId}_info";

  @override
  Future<UserInformationModel?> getUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();

    final userInfoJson = prefs.getString(_key(userId));

    if (userInfoJson == null) {
      return null;
    }

    return UserInformationModel.fromJson(jsonDecode(userInfoJson));
  }

  @override
  Future<void> addUser(UserInformationModel user) async {
    final prefs = await SharedPreferences.getInstance();

    final userInfoJson = jsonEncode(user.toJson());

    await prefs.setString(_key(user.id), userInfoJson);
  }
}
