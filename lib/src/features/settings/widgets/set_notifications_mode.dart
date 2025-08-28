import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/colors.dart';

import '../providers/settings_provider.dart';

class SetNotificationsMode extends StatelessWidget {
  const SetNotificationsMode({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.notifications,
          style: const TextStyle(
            color: MyColors.tetraryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Switch(
          activeColor: MyColors.secondaryColor,
          activeTrackColor: MyColors.primaryColor,
          value: settingsProvider.getNotification,
          onChanged: (value) {
            settingsProvider.changeNotification(value);
          },
        ),
      ],
    );
  }
}
