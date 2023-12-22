import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          const Text(
            "Speak search result",
            style: TextStyle(
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
                      "Always speak",
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
                      "When voice search",
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
                      "Never speak",
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
