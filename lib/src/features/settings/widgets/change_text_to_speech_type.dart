import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../providers/settings_provider.dart';

class ChangeTextToSpeechType extends StatelessWidget {
  const ChangeTextToSpeechType({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.speakSearchResult,
            style: const TextStyle(
              color: MyColors.tetraryColor,
              fontSize: 18,
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
