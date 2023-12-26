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
          constraints: const BoxConstraints(
            minWidth: 4.0 * 56.0,
            maxWidth: 300,
          ),
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
            return provider.allLocaleLanguagesWithDetails
                .map((languageWithDetail) => PopupMenuItem<String>(
                      value: languageWithDetail.languageCode,
                      child: Row(
                        children: [
                          Text(languageWithDetail.countryFlage),
                          const SizedBox(width: 20),
                          Text(
                            languageWithDetail.languageFullName,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          languageWithDetail.languageCode ==
                                  provider.currentLanguageCode
                              ? const Icon(Icons.check)
                              : const SizedBox(),
                        ],
                      ),
                    ))
                .toList();
          },
          onSelected: (String? languageCode) {
            provider.changeLocale(languageCode ?? provider.currentLanguageCode);
          },
        );
      },
    );
  }
}
