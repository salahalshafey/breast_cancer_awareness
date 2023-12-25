import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../core/util/widgets/column_or_row.dart';
import '../providers/settings_provider.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isColumn = screenWidth < 700;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: ColumnOrRow(
        isColumn: isColumn,
        mainAxisAlignment:
            isColumn ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            isColumn ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: const TextStyle(
              color: MyColors.tetraryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer<SettingsProvider>(
            builder: (context, provider, child) {
              return DropdownButton<String>(
                borderRadius: BorderRadius.circular(15),
                value: provider.currentLanguageCode,
                items: [
                  DropdownMenuItem<String>(
                    value: "system",
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.settings,
                              color: MyColors.primaryColor,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              AppLocalizations.of(context)!.systemDefault,
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
                  ...provider.allLocaleLanguagesWithDetails
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
                          ))
                ],
                onChanged: (String? languageCode) {
                  provider.changeLocale(
                      languageCode ?? provider.currentLanguageCode);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
