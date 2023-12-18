import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/settings_provider.dart';

class ChangLanguageForSignIn extends StatelessWidget {
  const ChangLanguageForSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        return PopupMenuButton<String>(
          icon: Text(
            provider.currentLanguageName,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          tooltip: AppLocalizations.of(context)!.changeLanguage,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          itemBuilder: (context) {
            return provider.allAvailableLanguagesWithDetails
                .map((localWithFlage) => PopupMenuItem<String>(
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
                          const Spacer(),
                          localWithFlage.languageCode ==
                                  provider.currentLanguageCode
                              ? const Icon(Icons.check)
                              : const SizedBox(),
                        ],
                      ),
                    ))
                .toList();
          },
          onSelected: (String? value) {
            provider.changeLocale(value ?? provider.currentLanguageCode);
          },
        );
      },
    );
  }
}
