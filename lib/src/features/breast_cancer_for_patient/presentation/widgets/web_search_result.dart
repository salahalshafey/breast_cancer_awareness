import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../core/util/functions/lang_detect.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../../core/util/widgets/custom_card.dart';
import '../../../../core/util/widgets/custom_error_widget.dart';
import '../../../../core/util/widgets/dots_loading.dart';

import '../../domain/entities/search_result.dart';
import '../../domain/entities/search_types.dart';

import '../../../settings/providers/settings_provider.dart';

import '../providers/instructions_with_lang.dart';
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
    final spokenStringLanguage = await detectLang(spokenString);

    if (await widget.flutterTts.isLanguageAvailable(spokenStringLanguage)) {
      await widget.flutterTts.setLanguage(spokenStringLanguage);

      widget.flutterTts.speak(spokenString);
      WakelockPlus.enable();
    }
  }

  void _speakIfPossible(
    FutureOr<String> spokenString,
    void Function(String) speakWith,
  ) async {
    final textToSpeechType =
        Provider.of<SettingsProvider>(context, listen: false).textToSpeechType;

    if (textToSpeechType == TextToSpeechType.alwaysSpeak ||
        textToSpeechType == TextToSpeechType.whenSearchWithVoiceOnly &&
            widget.textToSpeech) {
      speakWith(await spokenString);
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
      future: Provider.of<Search>(context, listen: false).customWebSearch(
        widget.searchWord,
        searchType: widget.searchType,
        numOfResult: 7,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final theSpokenError = snapshot.error.toString();

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

        final result = snapshot.data!;

        if (result.isEmpty) {
          final theSpokenError = AppLocalizations.of(context)!
              .yourSearchDidNotMatchAnyResultsWithDetails
              .replaceAll(
                RegExp(r"^\* |\*\*|`", multiLine: true, dotAll: false),
                "",
              );

          _speakIfPossible(theSpokenError, _speakWithCurrentLanguage);

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: CustomErrorWidget(
                iconSize: 50,
                error: AppLocalizations.of(context)!
                    .yourSearchDidNotMatchAnyResultsWithDetails,
              ),
            ),
          );
        }

        _speakIfPossible(_spokenString(result), _speakWithResultLanguage);

        return ListView(
          padding: const EdgeInsets.only(bottom: 10),
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      ...result.map(
                        (searchResult) => CustomCard(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 15),
                          borderRadius: BorderRadius.circular(15),
                          elevation: 5,
                          onTap: () {
                            launchUrl(
                              Uri.parse(searchResult.link),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    searchResult.image,
                                    height: 32,
                                    width: 32,
                                    errorBuilder: (ctx, error, stk) {
                                      return Image.asset(
                                        searchTypeToAssetImage(
                                            widget.searchType),
                                        height: 32,
                                        width: 32,
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      searchResult.title,
                                      textAlign: TextAlign.center,
                                      textDirection:
                                          firstCharIsRtl(searchResult.title)
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Text(
                                searchResult.snippet,
                                textAlign: TextAlign.justify,
                                textDirection:
                                    firstCharIsRtl(searchResult.snippet)
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ].animate(interval: 100.ms).fade().moveX(
                          begin: Directionality.of(context) == TextDirection.ltr
                              ? -15
                              : 15,
                          end: 0,
                        ),
                  ),
                ),
                Image.asset(
                  searchTypeToAssetImage(widget.searchType),
                  height: widget.searchType == SearchTypes.wikipedia ? 55 : 50,
                ).animate(delay: 200.ms).fade().moveY(),
                if (widget.searchType == SearchTypes.googleScholar)
                  Positioned(
                    right: 0,
                    top: 20,
                    child: Text(
                      AppLocalizations.of(context)!.articles,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black54
                            : Colors.grey,
                      ),
                    ),
                  ).animate(delay: 200.ms).fade().moveY(),
              ],
            ),
          ],
        );
      },
    );
  }
}

Future<String> _spokenString(List<SearchResult> result) async {
  if (result.length == 1) {
    return "${result.first.title}.\n${result.first.snippet}.";
  }

  final theResultLanguage =
      await detectLang("${result.first.title}.\n${result.first.snippet}");

  final instructions = INSTRUCTIONS[theResultLanguage] ?? INSTRUCTIONS['en'];

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
