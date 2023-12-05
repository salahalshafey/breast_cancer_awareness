import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);

    return IconButton(
      onPressed: () => provider.toggleThemeMode(context),
      tooltip: Theme.of(context).brightness == Brightness.dark
          ? "Change to Light Mode"
          : "Change to Dark Mode",
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.dark_mode //light_mode
            : Icons.light_mode,
      ),
    );
  }
}
