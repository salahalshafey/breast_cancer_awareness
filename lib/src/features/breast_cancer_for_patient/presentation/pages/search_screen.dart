// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../../../core/util/widgets/default_screen.dart';

import '../../../account/presentation/providers/account.dart';
import '../widgets/ai_result.dart';
import '../widgets/google_result.dart';
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
    final account = Provider.of<Account>(context, listen: false);
    final user = await account.getUserInfo();

    if (user == null || user.userType == "guest") {
      final color = Theme.of(context).appBarTheme.foregroundColor;

      showCustomAlretDialog(
        context: context,
        title: "Sign In",
        titleColor: color,
        content: "You have to Sign In to continue!!",
        actions: [
          TextButton(
            onPressed: () {
              account.signOut(context);
              Navigator.of(context)
                ..pop()
                ..pop();
            },
            child: Text(
              "Sign In",
              style: TextStyle(color: color),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Later",
              style: TextStyle(color: color),
            ),
          ),
        ],
      );
      return true;
    }

    return false;
  }

  void _setSearchWord(String searchword, {bool textToSpeech = false}) async {
    if (await _isGuest()) {
      return;
    }

    if (searchword == _searchWord && textToSpeech == _textToSpeech) {
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
          title: "Caution",
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
            left: 0,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
              tooltip: "Back",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 70),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: SearchField(
                    controller: _controller,
                    hintText:
                        _searchType == SearchTypes.ai ? "Ask AI" : "Search",
                    flutterTts: _flutterTts,
                    setSearchWord: _setSearchWord,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: SearchKeyWords(_setSearchWord)),
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
                    child: GoogleResult(
                      searchWord: _searchWord!,
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

enum SearchTypes {
  google,
  ai,
}
