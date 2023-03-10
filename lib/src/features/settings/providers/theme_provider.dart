import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this.currentTheme);
  String currentTheme;

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  void changeTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('theme', theme);

    currentTheme = theme;
    notifyListeners();
  }

  void toggleThemeMode(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      changeTheme("light");
    } else {
      changeTheme("dark");
    }
  }
}
