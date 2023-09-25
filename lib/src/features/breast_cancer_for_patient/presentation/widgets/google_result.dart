import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../core/util/functions/string_manipulations_and_search.dart';

import '../../../../core/util/widgets/custom_card.dart';
import '../../../../core/util/widgets/custom_error_widget.dart';
import '../../../../core/util/widgets/dots_loading.dart';
import '../../domain/entities/google_search_result.dart';
import '../providers/search.dart';

class GoogleResult extends StatefulWidget {
  const GoogleResult({
    super.key,
    required this.searchWord,
    required this.textToSpeech,
    required this.flutterTts,
  });

  final String searchWord;
  final bool textToSpeech;
  final FlutterTts flutterTts;

  @override
  State<GoogleResult> createState() => _GoogleResultState();
}

class _GoogleResultState extends State<GoogleResult>
    with WidgetsBindingObserver {
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
      future: Provider.of<Search>(context, listen: false).customGoogleSearch(
        widget.searchWord,
        numOfResult: 5,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (widget.textToSpeech) {
            widget.flutterTts.speak(snapshot.error.toString());
            Wakelock.enable();
          }

          return Center(
            child: CustomErrorWidget(error: snapshot.error.toString()),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: DotsLoading());
        }

        final result = snapshot.data!;

        if (widget.textToSpeech) {
          //widget.flutterTts.setLanguage("ar");
          widget.flutterTts.speak(_spokenString(result));
          Wakelock.enable();
        }

        return ListView(
          padding: const EdgeInsets.only(bottom: 10),
          children: result
              .map(
                (googleSearchResult) => CustomCard(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 15),
                  borderRadius: BorderRadius.circular(15),
                  elevation: 5,
                  onTap: () {
                    launchUrl(
                      Uri.parse(googleSearchResult.link),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        googleSearchResult.title,
                        textAlign: TextAlign.center,
                        textDirection:
                            firstCharIsArabic(googleSearchResult.title)
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      Text(
                        googleSearchResult.snippet,
                        textAlign: TextAlign.justify,
                        textDirection:
                            firstCharIsArabic(googleSearchResult.snippet)
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                      ),
                    ],
                  ),
                ),
              )
              .toList()
              .animate(interval: 100.ms)
              .fade()
              .moveX(),
        );
      },
    );
  }
}

String _spokenString(List<GoogleSearchResult> result) {
  if (result.isEmpty) {
    return "";
  }

  final instructions = firstCharIsArabic(result.first.title)
      ? "فيما يلي نتائج أخرى، يمكنك الضغط على أي من هذه النتائج لفتحها."
      : "Below is another search results. You can tap on any result to open it.";

  return "${result.first.title}.\n${result.first.snippet}.\n $instructions";
}
