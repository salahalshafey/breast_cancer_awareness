import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../providers/settings_provider.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      // alignment: AlignmentDirectional.centerStart,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: const TextStyle(
              color: MyColors.tetraryColor,
              fontSize: 20,
            ),
          ),
          Consumer<SettingsProvider>(
            builder: (context, provider, child) {
              return DropdownButton<String>(
                value: provider.currentLanguageCode,
                items: provider.allAvailableLanguagesWithDetails
                    .map((localWithFlage) => DropdownMenuItem<String>(
                          value: localWithFlage.languageCode,
                          child: Row(
                            children: [
                              Text(localWithFlage.countryFlage),
                              const SizedBox(width: 20),
                              Text(
                                localWithFlage.languageFullName,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (String? value) {
                  provider.changeLocale(value ?? provider.currentLanguageCode);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
