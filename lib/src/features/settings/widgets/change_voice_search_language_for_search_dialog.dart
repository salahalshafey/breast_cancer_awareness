import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../providers/settings_provider.dart';

class ChangViceSearchLanguageForSearchDialog extends StatelessWidget {
  const ChangViceSearchLanguageForSearchDialog(
    this.stopListing,
    this.startListing, {
    super.key,
  });

  final void Function() stopListing;
  final void Function() startListing;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        return PopupMenuButton<String>(
          icon: Row(
            children: [
              Text(
                provider.currentVoiceSearchLanguageName,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.language,
                color: MyColors.primaryColor,
              ),
            ],
          ),
          tooltip:
              AppLocalizations.of(context)!.selectALanguageToUseVoiceSearch,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          itemBuilder: (context) {
            return provider.allAvailableVoiceSearchLanguagesWithDetails
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
                                  provider.currentVoiceSearchLanguageCode
                              ? const Icon(Icons.check)
                              : const SizedBox(),
                        ],
                      ),
                    ))
                .toList();
          },
          onSelected: (String? languageCode) {
            provider.changeVoiceSearchLanguage(
              languageCode ?? provider.currentVoiceSearchLanguageCode,
            );

            startListing();
          },
          onCanceled: startListing,
          onOpened: stopListing,
        );
      },
    );
  }
}
