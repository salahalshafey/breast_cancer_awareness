import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return IconButton(
      onPressed: provider.toggleThemeMode,
      tooltip: provider.themeMode == ThemeMode.light
          ? "Change to System Mode"
          : provider.themeMode == ThemeMode.dark
              ? "Change to Light Mode"
              : "Change to Dark Mode",
      icon: Icon(
        provider.themeMode == ThemeMode.light
            ? Icons.light_mode
            : provider.themeMode == ThemeMode.dark
                ? Icons.dark_mode
                : Icons.brightness_6,
      ),
    );
  }
}
