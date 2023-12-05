import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../breast_cancer_for_normal/presentation/providers/notification.dart';

class SettingsProvider with ChangeNotifier {
  SettingsProvider(this._userSettings);

  Settings _userSettings;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////// theme ///////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  String get currentTheme => _userSettings.theme;

  ThemeMode get themeMode {
    if (_userSettings.theme == 'light') {
      return ThemeMode.light;
    } else if (_userSettings.theme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  void changeTheme(String theme) {
    _userSettings = _userSettings.copyWith(theme: theme);
    _saveSettings();

    notifyListeners();
  }

  void toggleThemeMode(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      changeTheme("light");
    } else {
      changeTheme("dark");
    }
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////// language ////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  String get currentLanguage => _userSettings.language;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////// notifications ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  bool get getNotification => _userSettings.notification;

  void changeNotification(bool notification) async {
    if (!notification) {
      await Noti.cancelNotification();
    }

    _userSettings = _userSettings.copyWith(notification: notification);
    _saveSettings();

    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////// save the settings in local //////////////////////////
////////////////////////////////////////////////////////////////////////////////

  void _saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('settings', jsonEncode(_userSettings.toJson()));
  }
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////// Setting model ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

class Settings {
  final String theme;
  final String language;
  final bool notification;

  const Settings({
    required this.theme,
    required this.language,
    required this.notification,
  });

  Settings.defaultValues()
      : theme = "system",
        language = "english",
        notification = true;

  factory Settings.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Settings.defaultValues();
    }

    return Settings(
      theme: json["theme"] ?? "system",
      language: json["language"] ?? "english",
      notification: json["notification"] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'theme': theme,
        'language': language,
        'notification': notification,
      };

  Settings copyWith({
    String? theme,
    String? language,
    bool? notification,
  }) {
    return Settings(
      theme: theme ?? this.theme,
      language: language ?? this.language,
      notification: notification ?? this.notification,
    );
  }

  @override
  String toString() {
    return "current theme: $theme\n"
        "current language: $language\n"
        "get notification: $notification\n";
  }
}
