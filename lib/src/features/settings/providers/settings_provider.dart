import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app.dart';
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

  String get currentLanguageCode {
    final context = navigatorKey.currentContext!;

    if (_userSettings.languageCode == null) {
      return Localizations.localeOf(context).languageCode;
    }

    return _userSettings.languageCode!;
  }

  String get currentLanguageName => allAvailableLanguagesWithDetails
      .firstWhere((localWithDetail) =>
          localWithDetail.languageCode == currentLanguageCode)
      .languageFullName;

  Locale? get currentLocale => _userSettings.languageCode == null
      ? null
      : Locale(_userSettings.languageCode!);

  List<LocaleWithCountryFlage> get allAvailableLanguagesWithDetails {
    final context = navigatorKey.currentContext!;

    return [
      LocaleWithCountryFlage(
        "en",
        AppLocalizations.of(context)!.english,
        "🇺🇸",
      ),
      LocaleWithCountryFlage(
        "ar",
        AppLocalizations.of(context)!.arabic,
        "🇪🇬",
      ),
    ];
  }

  void changeLocale(String languageCode) {
    _userSettings = _userSettings.copyWith(languageCode: languageCode);
    _saveSettings();

    notifyListeners();
  }

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
/////////////////// save the settings in local And reset ///////////////////////
////////////////////////////////////////////////////////////////////////////////

  void _saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('settings', jsonEncode(_userSettings.toJson()));
  }

  void restSettings() {
    _userSettings = Settings.defaultValues();

    _saveSettings();
    notifyListeners();
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////// Setting model ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

class Settings {
  final String theme;
  final String? languageCode;
  final bool notification;

  const Settings({
    required this.theme,
    required this.languageCode,
    required this.notification,
  });

  Settings.defaultValues()
      : theme = "system",
        languageCode = null,
        notification = true;

  factory Settings.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Settings.defaultValues();
    }

    return Settings(
      theme: json["theme"] ?? "system",
      languageCode: json["language_code"],
      notification: json["notification"] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'theme': theme,
        'language_code': languageCode,
        'notification': notification,
      };

  Settings copyWith({
    String? theme,
    String? languageCode,
    bool? notification,
  }) {
    return Settings(
      theme: theme ?? this.theme,
      languageCode: languageCode ?? this.languageCode,
      notification: notification ?? this.notification,
    );
  }

  @override
  String toString() {
    return "current theme: $theme\n"
        "current language Code: $languageCode\n"
        "get notification: $notification\n";
  }
}

class LocaleWithCountryFlage {
  final String languageCode;
  final String languageFullName;
  final String countryFlage;

  const LocaleWithCountryFlage(
    this.languageCode,
    this.languageFullName,
    this.countryFlage,
  );
}
