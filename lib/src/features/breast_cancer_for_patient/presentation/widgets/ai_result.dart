import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

import '../../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../../core/util/classes/pair_class.dart';

import '../../../../core/util/widgets/bulleted_list.dart';
import '../../../../core/util/widgets/code_container.dart';
import '../../../../core/util/widgets/custom_card.dart';
import '../../../../core/util/widgets/custom_error_widget.dart';
import '../../../../core/util/widgets/dots_loading.dart';
import '../../../../core/util/widgets/text_well_formatted.dart';

import '../../../settings/providers/settings_provider.dart';
import '../providers/search.dart';

class AIResult extends StatefulWidget {
  const AIResult({
    super.key,
    required this.searchWord,
    required this.textToSpeech,
    required this.flutterTts,
  });

  final String searchWord;
  final bool textToSpeech;
  final FlutterTts flutterTts;

  @override
  State<AIResult> createState() => _AIResultState();
}

class _AIResultState extends State<AIResult> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    widget.flutterTts.setCompletionHandler(() {
      WakelockPlus.disable();
    });

    widget.flutterTts.setCancelHandler(() {
      WakelockPlus.disable();
    });

    super.initState();
  }

  void _speakWithCurrentLanguage(String spokenString) async {
    final currentAppLanguage = Localizations.localeOf(context).languageCode;

    if (await widget.flutterTts.isLanguageAvailable(currentAppLanguage)) {
      await widget.flutterTts.setLanguage(currentAppLanguage);

      widget.flutterTts.speak(spokenString);
      WakelockPlus.enable();
    }
  }

  void _speakWithResultLanguage(String spokenString) async {
    final spokenStringLanguage = langdetect.detect(spokenString);

    // print(spokenStringLanguage);
    if (await widget.flutterTts.isLanguageAvailable(spokenStringLanguage)) {
      // print("Avaliable");
      await widget.flutterTts.setLanguage(spokenStringLanguage);

      widget.flutterTts.speak(spokenString);
      WakelockPlus.enable();
    }
  }

  void _speakIfPossible(String spokenString, void Function(String) speakWith) {
    final textToSpeechType =
        Provider.of<SettingsProvider>(context, listen: false).textToSpeechType;

    if (textToSpeechType == TextToSpeechType.alwaysSpeak ||
        textToSpeechType == TextToSpeechType.whenSearchWithVoiceOnly &&
            widget.textToSpeech) {
      speakWith(spokenString);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.flutterTts.stop();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    widget.flutterTts.stop();
    WakelockPlus.disable();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: UniqueKey(),
      future: //chatGPT(widget.searchWord),
          Provider.of<Search>(context, listen: false)
              .aiChatSearch(widget.searchWord),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final theSpokenError = snapshot.error.toString().replaceAll(
                RegExp(r"^\* |\*\*|`", multiLine: true, dotAll: false),
                "",
              );

          _speakIfPossible(theSpokenError, _speakWithCurrentLanguage);

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: CustomErrorWidget(
                iconSize: 50,
                error: snapshot.error.toString(),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: DotsLoading());
        }

        final result = patternMatcher(
          snapshot.data!,
          patterns: [
            // code
            RegExp(
              r"^```.*?```",
              multiLine: true,
              dotAll: true,
            ),

            // bulleted
            RegExp(
              r"^\* .*",
              multiLine: true,
              dotAll: false,
            ),
          ],
          types: [
            StringTypes.code,
            StringTypes.bulleted,
            StringTypes.normal,
          ],
        );

        _speakIfPossible(_spokenString(result), _speakWithResultLanguage);

        return ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 30),
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                CustomCard(
                  padding: const EdgeInsets.all(10)
                      .add(const EdgeInsets.only(top: 20)),
                  borderRadius: BorderRadius.circular(15),
                  child: Column(
                    children: result.map((inlineString) {
                      if (inlineString.type == StringTypes.code) {
                        final code =
                            _getCodeAndlanguageName(inlineString.string);

                        return CodeContainer(
                          code: code.first,
                          languageName: code.second,
                          animateTheCode: true,
                        );
                      }

                      if (inlineString.type == StringTypes.bulleted) {
                        return BulletedList(
                          textDirection: getDirectionalityOf(snapshot.data!),
                          text: TextWellFormattedWitouthBulleted(
                            data: inlineString.string.substring(2),
                            isSelectableText: true,
                            textDirection: getDirectionalityOf(snapshot.data!),
                          ),
                        );
                      }

                      return TextWellFormattedWitouthBulleted(
                        data: inlineString.string,
                        isSelectableText: true,
                        textDirection: getDirectionalityOf(snapshot.data!),
                      );
                    }).toList(),
                  ),
                ).animate().fade(duration: 200.ms).moveX(
                      duration: 200.ms,
                      begin: Directionality.of(context) == TextDirection.ltr
                          ? -15
                          : 15,
                      end: 0,
                    ),
                Transform.translate(
                  offset: const Offset(0.0, -30.0),
                  child: Image.asset("assets/images/ai.png", height: 55)
                      .animate(delay: 200.ms)
                      .fade()
                      .moveY(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

String _spokenString(List<StringWithType<StringTypes>> data) {
  String spoken = "";

  for (final inlineString in data) {
    if (inlineString.type != StringTypes.code) {
      spoken += "${inlineString.string}\n";
    }
  }
  return spoken.replaceAll(
    RegExp(r"^\* |\*\*|`", multiLine: true, dotAll: false),
    "",
  );
}

Pair<String, String> _getCodeAndlanguageName(String code) {
  final codelist = code.split("\n");

  final programmingLanguage = codelist.first.substring(3).trim();

  final theCode = codelist.sublist(1, codelist.length - 1).join("\n");

  return Pair(theCode, programmingLanguage);
}

enum StringTypes {
  code,
  bulleted,
  normal,
}
