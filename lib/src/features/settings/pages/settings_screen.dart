import 'package:breast_cancer_awareness/src/core/util/extensions/list_seperator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/util/widgets/default_screen.dart';

import '../providers/settings_provider.dart';

import '../widgets/change_language.dart';
import '../widgets/change_voice_search_language.dart';
import '../widgets/change_text_to_speech_type.dart';
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
          tooltip: AppLocalizations.of(context)!.resetToDefault,
          icon: const Icon(Icons.restart_alt),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        children: const [
          SizedBox(height: 10),
          SetThemeMode(),
          ChangeLanguage(),
          SetNotificationsMode(),
          ChangeTextToSpeechType(),
          ChangeVoiceSearchLanguage(),
        ].verticalSeperateBy(const SizedBox(height: 50)),
      ),
    );
  }
}
