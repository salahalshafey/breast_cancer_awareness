// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/util/builders/custom_alret_dialog.dart';
import '../../../../core/util/builders/custom_snack_bar.dart';
import '../../../../core/util/widgets/default_screen.dart';

import '../../../account/domain/entities/user_information.dart';
import '../../../account/presentation/providers/account.dart';
import '../../domain/entities/search_types.dart';
import '../widgets/ai_result.dart';
import '../widgets/web_search_result.dart';
import '../widgets/search_field.dart';
import '../widgets/search_keywords.dart';
import '../widgets/search_type_choices.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _searchWord;
  bool _textToSpeech = false;
  SearchTypes _searchType = SearchTypes.ai;

  final _controller = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();

  Future<bool> _isGuest() async {
    try {
      final account = Provider.of<Account>(context, listen: false);
      final user = await account.getUserInfo();

      if (user == null || user.userType == UserTypes.guest) {
        final color = Theme.of(context).appBarTheme.foregroundColor;

        showCustomAlretDialog(
          context: context,
          title: "Sign In",
          titleColor: color,
          content: "You have to Sign In to continue!!",
          actionsBuilder: (dialogContext) => [
            OutlinedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(color),
                side: MaterialStatePropertyAll(BorderSide(color: color!)),
              ),
              child: const Text("Later"),
            ),
            ElevatedButton(
              onPressed: () {
                account.signOut(dialogContext);
                Navigator.of(dialogContext)
                  ..pop()
                  ..pop();
              },
              style:
                  ButtonStyle(backgroundColor: MaterialStatePropertyAll(color)),
              child: const Text("Sign In"),
            ),
          ],
        );
        return true;
      }

      return false;
    } catch (error) {
      showCustomSnackBar(
        context: context,
        content: error.toString(),
      );

      return false;
    }
  }

  void _setSearchWord(String searchword, {bool textToSpeech = false}) async {
    if (await _isGuest()) {
      return;
    }

    if (searchword.isTheSameAS(_searchWord) && textToSpeech == _textToSpeech) {
      return;
    }

    _flutterTts.stop();

    setState(() {
      _searchWord = searchword;
      _textToSpeech = textToSpeech;
    });

    _controller.text = searchword;
  }

  void _setSearchType(SearchTypes searchType) {
    if (searchType == _searchType) {
      return;
    }

    _flutterTts.stop();

    setState(() {
      _searchType = searchType;
    });
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        showCustomAlretDialog(
          context: context,
          constraints: const BoxConstraints(maxWidth: 600),
          title: "Warning",
          contentFontSize: 14,
          content:
              "This app provides information and assistance related to `medical` topics using `artificial intelligence` and `online resources`. However, it is not a substitute for professional medical advice, diagnosis, or treatment. Please read and consider the following:\n\n"
              "* **Consult a Healthcare Professional:** If you have a medical condition, symptoms, or concerns about your health, consult a qualified healthcare provider. This app does not replace the expertise of medical professionals.\n"
              "* **Use as a Supplement:** Use this app as a supplemental tool to gather general information about medical topics. It can provide insights and suggestions but should not be your sole source of healthcare guidance.\n"
              "* **Not for Emergencies:** In case of a medical emergency, call your local emergency number or seek immediate medical attention. This app is not equipped to handle urgent situations.\n"
              "* **Verify Information:** Always verify the information you receive in this app with trusted medical sources or professionals. Medical knowledge evolves, and information provided here may not always reflect the latest guidelines.\n"
              "* **User Responsibility:** Your health is your responsibility. Do not make medical decisions solely based on information obtained from this app.",
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingAppBar: false,
      containingBackgroundCancerSympol: false,
      containingBackgroundRightSympol: false,
      child: Stack(
        children: [
          Positioned(
            top: 70,
            left: Directionality.of(context) == TextDirection.ltr ? 0 : null,
            right: Directionality.of(context) == TextDirection.rtl ? 0 : null,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
              tooltip: AppLocalizations.of(context)!.back,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 70),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 35),
                  child: SearchField(
                    controller: _controller,
                    hintText: _searchTypeToString(_searchType),
                    flutterTts: _flutterTts,
                    setSearchWord: _setSearchWord,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SearchKeyWords(_searchWord, _setSearchWord),
                    ),
                    SearchTypeChoices(
                      searchType: _searchType,
                      setSearchType: _setSearchType,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (_searchWord == null)
                  Expanded(
                    child: Center(
                      child: Opacity(
                        opacity: Theme.of(context).brightness == Brightness.dark
                            ? 0.8
                            : 1,
                        child: Image.asset("assets/breast_cancer/search_2.png"),
                      ),
                    ),
                  )
                else if (_searchType == SearchTypes.ai)
                  Expanded(
                    child: AIResult(
                      searchWord: _searchWord!,
                      textToSpeech: _textToSpeech,
                      flutterTts: _flutterTts,
                    ),
                  )
                else
                  Expanded(
                    child: WebSearchResult(
                      searchWord: _searchWord!,
                      searchType: _searchType,
                      textToSpeech: _textToSpeech,
                      flutterTts: _flutterTts,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _searchTypeToString(SearchTypes searchType) {
  switch (searchType) {
    case SearchTypes.ai:
      return "Ask AI";
    case SearchTypes.google:
      return "Google Search";
    case SearchTypes.googleScholar:
      return "Google Scholar Search";
    case SearchTypes.wikipedia:
      return "Wikipedia Search";
  }
}
