import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../../core/util/classes/pair_class.dart';

import '../../../../core/util/widgets/bulleted_list.dart';
import '../../../../core/util/widgets/code_container.dart';
import '../../../../core/util/widgets/custom_card.dart';
import '../../../../core/util/widgets/custom_error_widget.dart';
import '../../../../core/util/widgets/dots_loading.dart';

import '../../../../core/util/widgets/text_well_formatted.dart';
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
      Wakelock.disable();
    });

    widget.flutterTts.setCancelHandler(() {
      Wakelock.disable();
    });

    super.initState();
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
    Wakelock.disable();

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
          if (widget.textToSpeech) {
            widget.flutterTts.speak(snapshot.error.toString());
            Wakelock.enable();
          }

          return Center(
            child: CustomErrorWidget(
              iconSize: 50,
              error: snapshot.error.toString(),
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

        if (widget.textToSpeech) {
          widget.flutterTts.speak(_spokenString(result));
          Wakelock.enable();
        }

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
                        );
                      }

                      if (inlineString.type == StringTypes.bulleted) {
                        return BulletedList(
                          textDirection: firstCharIsRtl(snapshot.data!)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          text: TextWellFormattedWitouthBulleted(
                            data: inlineString.string.substring(2),
                            isSelectableText: true,
                          ),
                        );
                      }

                      return TextWellFormattedWitouthBulleted(
                        data: inlineString.string,
                        isSelectableText: true,
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
