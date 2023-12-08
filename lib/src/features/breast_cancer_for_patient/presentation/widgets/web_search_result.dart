import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../../core/util/widgets/custom_card.dart';
import '../../../../core/util/widgets/custom_error_widget.dart';
import '../../../../core/util/widgets/dots_loading.dart';

import '../../domain/entities/search_result.dart';
import '../../domain/entities/search_types.dart';

import '../providers/search.dart';

class WebSearchResult extends StatefulWidget {
  const WebSearchResult({
    super.key,
    required this.searchWord,
    required this.searchType,
    required this.textToSpeech,
    required this.flutterTts,
  });

  final String searchWord;
  final SearchTypes searchType;
  final bool textToSpeech;
  final FlutterTts flutterTts;

  @override
  State<WebSearchResult> createState() => _WebSearchResultState();
}

class _WebSearchResultState extends State<WebSearchResult>
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
      future: Provider.of<Search>(context, listen: false).customWebSearch(
        widget.searchWord,
        searchType: widget.searchType,
        numOfResult: 7,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (widget.textToSpeech) {
            widget.flutterTts.speak(snapshot.error.toString());
            Wakelock.enable();
          }

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

        final result = snapshot.data!;

        if (widget.textToSpeech) {
          //widget.flutterTts.setLanguage("ar");
          widget.flutterTts.speak(_spokenString(result));
          Wakelock.enable();
        }

        if (result.isEmpty) {
          return const Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: CustomErrorWidget(
                iconSize: 50,
                error: "**Your search did not match any results**\n\n"
                    "* Make sure all words are spelled correctly or Try different keywords.\n"
                    "* Or maybe you are using a **language** that is not supported yet.",
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.only(bottom: 10),
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      ...result.map(
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
                                textDirection: firstCharIsArabic(
                                        googleSearchResult.snippet)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ].animate(interval: 100.ms).fade().moveX(),
                  ),
                ),
                Image.asset(
                  searchTypeToAssetImage(widget.searchType),
                  height: widget.searchType == SearchTypes.wikipedia ? 55 : 50,
                ).animate(delay: 200.ms).fade().moveY(),
              ],
            ),
          ],
        );
      },
    );
  }
}

String _spokenString(List<SearchResult> result) {
  if (result.isEmpty) {
    return "Your search did not match any results.\n\n"
        "Make sure all words are spelled correctly or Try different keywords.\n"
        "Or maybe you are using a language that is not supported yet.";
  }

  final instructions = firstCharIsArabic(result.first.title)
      ? "فيما يلي نتائج أخرى، يمكنك الضغط على أي من هذه النتائج لفتحها."
      : "Below is another search results. You can tap on any result to open it.";

  return "${result.first.title}.\n${result.first.snippet}.\n $instructions";
}

String searchTypeToAssetImage(SearchTypes searchType) {
  switch (searchType) {
    case SearchTypes.ai:
      return "assets/images/ai.png";
    case SearchTypes.google:
      return "assets/images/google.png";
    case SearchTypes.googleScholar:
      return "assets/images/google_scholar.png";
    case SearchTypes.wikipedia:
      return "assets/images/wikipedia.png";
  }
}
