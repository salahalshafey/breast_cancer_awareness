import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/util/widgets/default_screen.dart';

import '../widgets/set_notifications_mode.dart';
import '../widgets/set_theme_mode.dart';

class SettingsScreen extends StatelessWidget {
  static const routName = '/profile';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBartitle: "Settings",
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        children: const [
          SizedBox(height: 60),
          SetThemeMode(),
          SizedBox(height: 30),
          Text(
            "Language",
            style: TextStyle(
              color: MyColors.tetraryColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 30),
          SetNotificationsMode(),
          SizedBox(height: 30),
          Text(
            "Search Engine",
            style: TextStyle(
              color: MyColors.tetraryColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
