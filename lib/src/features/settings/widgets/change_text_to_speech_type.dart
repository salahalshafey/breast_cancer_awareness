import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/colors.dart';
import '../../../core/util/widgets/column_or_row.dart';

import '../providers/settings_provider.dart';

class ChangeTextToSpeechType extends StatelessWidget {
  const ChangeTextToSpeechType({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isColumn = screenWidth < 600;

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
            AppLocalizations.of(context)!.speakSearchResult,
            style: const TextStyle(
              color: MyColors.tetraryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer<SettingsProvider>(
            builder: (context, provider, child) {
              return DropdownButton<TextToSpeechType>(
                borderRadius: BorderRadius.circular(15),
                value: provider.textToSpeechType,
                items: [
                  DropdownMenuItem<TextToSpeechType>(
                    value: TextToSpeechType.alwaysSpeak,
                    child: Text(
                      AppLocalizations.of(context)!.alwaysSpeak,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DropdownMenuItem<TextToSpeechType>(
                    value: TextToSpeechType.whenSearchWithVoiceOnly,
                    child: Text(
                      AppLocalizations.of(context)!.whenVoiceSearch,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DropdownMenuItem<TextToSpeechType>(
                    value: TextToSpeechType.neverSpeak,
                    child: Text(
                      AppLocalizations.of(context)!.neverSpeak,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                onChanged: (textToSpeechType) {
                  provider.changeTextToSpeechType(
                      textToSpeechType ?? TextToSpeechType.alwaysSpeak);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
