import 'package:breast_cancer_awareness/src/features/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/util/widgets/default_screen.dart';

import '../widgets/change_language.dart';
import '../widgets/set_notifications_mode.dart';
import '../widgets/set_theme_mode.dart';

class SettingsScreen extends StatelessWidget {
  static const routName = '/profile';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBartitle: AppLocalizations.of(context)!.settings,
      appBarActions: [
        IconButton(
            onPressed: () {
              Provider.of<SettingsProvider>(context, listen: false)
                  .restSettings();
            },
            icon: Icon(Icons.restart_alt)),
      ],
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        children: const [
          SizedBox(height: 60),
          SetThemeMode(),
          SizedBox(height: 30),
          ChangeLanguage(),
          SizedBox(height: 30),
          SetNotificationsMode(),
          SizedBox(height: 30),
          /* Text(
            "Search Engine",
            style: TextStyle(
              color: MyColors.tetraryColor,
              fontSize: 18,
            ),
          ),*/
        ],
      ),
    );
  }
}
