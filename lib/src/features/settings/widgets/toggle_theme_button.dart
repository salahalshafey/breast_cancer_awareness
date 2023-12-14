import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/settings_provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);

    return IconButton(
      onPressed: () => provider.toggleThemeMode(context),
      tooltip: Theme.of(context).brightness == Brightness.dark
          ? AppLocalizations.of(context)!.changeToLightMode
          : AppLocalizations.of(context)!.changeToDarkMode,
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.dark_mode
            : Icons.light_mode,
      ),
    );
  }
}
