import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/colors.dart';

import '../providers/settings_provider.dart';

class SetThemeMode extends StatelessWidget {
  const SetThemeMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Theme",
            style: TextStyle(
              color: MyColors.tetraryColor,
              fontSize: 20,
            ),
          ),
          Consumer<SettingsProvider>(
            builder: (context, provider, child) {
              return DropdownButton<String>(
                value: provider.currentTheme,
                items: [
                  DropdownMenuItem<String>(
                    value: 'light',
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.light_mode),
                      label: Text(
                        "Light",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'dark',
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.dark_mode),
                      label: Text(
                        "Dark",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'system',
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.brightness_6),
                      label: Text(
                        "System default",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                onChanged: (String? value) {
                  provider.changeTheme(value ?? 'system');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
