import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../providers/settings_provider.dart';

class ChangeVoiceSearchLanguageForSearchDialog extends StatelessWidget {
  const ChangeVoiceSearchLanguageForSearchDialog(
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
          constraints: const BoxConstraints(
            minWidth: 4.0 * 56.0,
            maxWidth: 300,
          ),
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                provider.currentVoiceSearchLanguageName,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
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
          initialValue: provider.currentVoiceSearchLanguageCode,
          itemBuilder: (context) {
            return [
              ...provider.suggestedVoiceSearchLanguagesWithDetails
                  .map((languageWithDetail) => PopupMenuItem<String>(
                        value: languageWithDetail.languageCode,
                        child: Row(
                          children: [
                            Text(languageWithDetail.countryFlage),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                languageWithDetail.languageFullName,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //  const Spacer(),
                            languageWithDetail.languageCode ==
                                    provider.currentVoiceSearchLanguageCode
                                ? const Icon(Icons.check)
                                : const SizedBox(),
                          ],
                        ),
                      )),
              PopupMenuItem<String>(
                enabled: false,
                child: Align(
                  child: SeeAllAndChangeVoiceSearchLanguages(startListing),
                ),
              ),
            ];
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

class SeeAllAndChangeVoiceSearchLanguages extends StatelessWidget {
  const SeeAllAndChangeVoiceSearchLanguages(
    this.startListing, {
    super.key,
  });

  final void Function() startListing;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        return PopupMenuButton<String>(
          constraints: const BoxConstraints(
            minWidth: 2.0 * 56.0,
            maxWidth: 300,
          ),
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.allLanguages,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
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
          initialValue: provider.currentVoiceSearchLanguageCode,
          itemBuilder: (context) {
            return provider.allAvailableVoiceSearchLanguagesWithDetails
                .map((languageWithDetail) => PopupMenuItem<String>(
                      value: languageWithDetail.languageCode,
                      child: Row(
                        children: [
                          Text(languageWithDetail.countryFlage),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              languageWithDetail.languageFullName,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          //  const Spacer(),
                          languageWithDetail.languageCode ==
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
            Navigator.of(context).pop();
          },
          // onCanceled: startListing,
          //  onOpened: stopListing,
        );
      },
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

class ChangeVoiceSearchLanguageForSearchDialog2 extends StatelessWidget {
  const ChangeVoiceSearchLanguageForSearchDialog2(
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
          constraints: const BoxConstraints(
            minWidth: 2.0 * 56.0,
            maxWidth: 300,
          ),
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                provider.currentVoiceSearchLanguageName,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
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
          initialValue: provider.currentVoiceSearchLanguageCode,
          itemBuilder: (context) {
            return provider.allAvailableVoiceSearchLanguagesWithDetails
                .map((languageWithDetail) => PopupMenuItem<String>(
                      value: languageWithDetail.languageCode,
                      child: Row(
                        children: [
                          Text(languageWithDetail.countryFlage),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              languageWithDetail.languageFullName,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          //  const Spacer(),
                          languageWithDetail.languageCode ==
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

///////////////////////////////////////////////////////////////////
///

class ChangeVoiceSearchLanguageForSearchDialog3 extends StatelessWidget {
  const ChangeVoiceSearchLanguageForSearchDialog3(
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
        return DropdownButton<String>(
          icon: const SizedBox(),
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(15),
          selectedItemBuilder: (context) => [
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.settings,
                      color: MyColors.primaryColor,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      AppLocalizations.of(context)!.defaultWord,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
            ...provider.allAvailableVoiceSearchLanguagesWithDetails
                .map((languageWithDetail) => Text(
                      provider.currentVoiceSearchLanguageName,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
          ],
          value: provider.currentVoiceSearchLanguageCode,
          items: [
            DropdownMenuItem<String>(
              value: "system",
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.settings,
                        color: MyColors.primaryColor,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        AppLocalizations.of(context)!.defaultWord,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
            ...provider.allAvailableVoiceSearchLanguagesWithDetails
                .map((languageWithDetail) => DropdownMenuItem<String>(
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
                        ],
                      ),
                    )),
          ],
          onChanged: (String? languageCode) {
            provider.changeVoiceSearchLanguage(
                languageCode ?? provider.currentVoiceSearchLanguageCode);
          },
        );
      },
    );
  }
}
