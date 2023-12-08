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
                          textDirection: firstCharIsArabic(snapshot.data!)
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
                ),
                Transform.translate(
                  offset: const Offset(0.0, -30.0),
                  child: Image.asset("assets/images/ai.png", height: 55),
                ),
              ],
            ).animate().fade(duration: 200.ms).moveY(duration: 200.ms),
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

//////////////////////////////////////// test ////////////////////////////

Future<String> chatGPT(String searchWord) => Future.delayed(
      const Duration(seconds: 2),
      () {
        // throw Exception(searchWord);
        return """Flutter `Speech to Text` is a plugin that allows you to easily integrate speech recognition into your Flutter apps. It uses the Google Cloud Speech-to-Text API to convert audio to text, and it supports a variety of languages.

To use Flutter Speech to Text, you first need to create a project in the Google Cloud Platform Console. Once you have created a project, you need to enable the Google Cloud Speech-to-Text API.

After you have enabled the API, you need to create a service account and download the JSON key file. You will need to provide the JSON key file to the Flutter Speech to Text plugin.

There are many things you can do to reduce your **risk of breast cancer**, such as:



* Getting regular mammograms Flutter `Speech to Text` is a **plugin** that allows you www.sdsfsff.com

* Having regular breast exams

* Eating a healthy diet

* Exercising regularly

* Maintaining a healthy weight

* Not smoking

* Limiting alcohol intake

* Not taking hormones after menopause



If you are concerned about **breast cancer**, talk to your doctor.

To install the Flutter 'Speech to Text' plugin, you can use the following command:

```command
pub add flutter_speech_to_text
```

Once the plugin is installed, you can use it in your Flutter app. The following code snippet shows how to use the Flutter Speech to Text plugin to convert audio to text:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text/flutter_speech_to_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Speech to Text',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Speech to Text'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              // Create a SpeechToText object.
              final speechToText = SpeechToText();

              // Set the language code.
              speechToText.setLanguageCode('en-US');

              // Start listening for speech.
              final result = await speechToText.listen();

              // Print the result.
              print(result.text);
            },
            child: Text('Listen'),
          ),
        ),
      ),
    );
  }
}
```

see this link for more: https://translate.google.com.eg/?hl=en&sl=en&tl=ar&text=highlighted&op=translate the link is valid.

to email: salahalshafey@gmail.com and website: www.salahalshafey.com

When you run the app, you will see a button that says "Listen". When you click on the button, the app will start listening for speech. The text that is spoken will be converted to text and printed to the console.

Flutter `Speech to Text` is a powerful tool that can be used to add speech recognition to your Flutter apps. It is easy to use and supports a variety of languages.
""";
      },
    );
