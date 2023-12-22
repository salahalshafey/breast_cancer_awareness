import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app.dart';
import '../../breast_cancer_for_normal/presentation/providers/notification.dart';
import 'languages.dart';

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

    if (_userSettings.languageCode == "system") {
      return Localizations.localeOf(context).languageCode;
    }

    return _userSettings.languageCode;
  }

  String get currentLanguageName => allLocaleLanguagesWithDetails
      .firstWhere((localWithDetail) =>
          localWithDetail.languageCode == currentLanguageCode)
      .languageFullName;

  Locale? get currentLocale => _userSettings.languageCode == "system"
      ? null
      : Locale(_userSettings.languageCode);

  List<LocaleWithCountryFlage> get allLocaleLanguagesWithDetails =>
      Languages.allLocaleWithDetails
        ..sort((l1, l2) => l1.languageFullName.compareTo(l2.languageFullName));

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
/////////////////////////// text To Speech Type ////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  TextToSpeechType get textToSpeechType => _userSettings.textToSpeechType;

  void changeTextToSpeechType(TextToSpeechType textToSpeechType) async {
    _userSettings = _userSettings.copyWith(textToSpeechType: textToSpeechType);
    _saveSettings();

    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////// voice Search language ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  String get currentVoiceSearchLanguageCode {
    final context = navigatorKey.currentContext!;

    if (_userSettings.voiceSearchLanguageCode == "system") {
      return Localizations.localeOf(context).languageCode;
    }

    return _userSettings.voiceSearchLanguageCode;
  }

  String get currentVoiceSearchLanguageName =>
      allAvailableVoiceSearchLanguagesWithDetails
          .firstWhere((localWithDetail) =>
              localWithDetail.languageCode == currentVoiceSearchLanguageCode)
          .languageFullName;

  List<LocaleWithCountryFlage>
      get allAvailableVoiceSearchLanguagesWithDetails => Languages
          .allWithDetails
        ..sort((l1, l2) => l1.languageFullName.compareTo(l2.languageFullName));

  void changeVoiceSearchLanguage(String languageCode) {
    _userSettings =
        _userSettings.copyWith(voiceSearchLanguageCode: languageCode);
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
  final String languageCode;
  final bool notification;
  final TextToSpeechType textToSpeechType;
  final String voiceSearchLanguageCode;

  const Settings({
    required this.theme,
    required this.languageCode,
    required this.notification,
    required this.textToSpeechType,
    required this.voiceSearchLanguageCode,
  });

  Settings.defaultValues()
      : theme = "system",
        languageCode = "system",
        notification = true,
        textToSpeechType = TextToSpeechType.alwaysSpeak,
        voiceSearchLanguageCode = "system";

  factory Settings.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Settings.defaultValues();
    }

    return Settings(
      theme: json["theme"] ?? "system",
      languageCode: json["language_code"] ?? "system",
      notification: json["notification"] ?? true,
      textToSpeechType:
          (json["text_to_speech_type"] as String?).toTextToSpeechType,
      voiceSearchLanguageCode: json["speech_to_text_language_code"] ?? "system",
    );
  }

  Map<String, dynamic> toJson() => {
        'theme': theme,
        'language_code': languageCode,
        'notification': notification,
        'text_to_speech_type': textToSpeechType.toStringValue,
        'speech_to_text_language_code': voiceSearchLanguageCode,
      };

  Settings copyWith({
    String? theme,
    String? languageCode,
    bool? notification,
    TextToSpeechType? textToSpeechType,
    String? voiceSearchLanguageCode,
  }) {
    return Settings(
      theme: theme ?? this.theme,
      languageCode: languageCode ?? this.languageCode,
      notification: notification ?? this.notification,
      textToSpeechType: textToSpeechType ?? this.textToSpeechType,
      voiceSearchLanguageCode:
          voiceSearchLanguageCode ?? this.voiceSearchLanguageCode,
    );
  }

  @override
  String toString() {
    return "current theme: $theme\n"
        "current language Code: $languageCode\n"
        "get notification: $notification\n"
        "text To Speech Type: $textToSpeechType\n"
        "speech To Text Language Code: $voiceSearchLanguageCode\n";
  }
}

enum TextToSpeechType {
  alwaysSpeak,
  whenSearchWithVoiceOnly,
  neverSpeak,
}

extension on TextToSpeechType {
  String get toStringValue {
    switch (this) {
      case TextToSpeechType.alwaysSpeak:
        return "alwaysSpeak";
      case TextToSpeechType.whenSearchWithVoiceOnly:
        return "whenSearchWithVoiceOnly";
      case TextToSpeechType.neverSpeak:
        return "neverSpeak";
    }
  }
}

extension on String? {
  TextToSpeechType get toTextToSpeechType {
    switch (this) {
      case "alwaysSpeak":
        return TextToSpeechType.alwaysSpeak;
      case "whenSearchWithVoiceOnly":
        return TextToSpeechType.whenSearchWithVoiceOnly;
      case "neverSpeak":
        return TextToSpeechType.neverSpeak;
      default:
        return TextToSpeechType.alwaysSpeak;
    }
  }
}
