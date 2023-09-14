import 'package:flutter/material.dart';

import '../../../../core/util/widgets/default_screen.dart';

import '../widgets/chat_gpt_search_result.dart';
import '../widgets/search_field.dart';
import '../widgets/search_keywords.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _searchWord;
  bool _textToSpeech = false;
  final _controller = TextEditingController();

  void _setSearchWord(String searchword, {bool textToSpeech = false}) {
    setState(() {
      _searchWord = searchword;
      _textToSpeech = textToSpeech;
    });

    _controller.text = searchword;
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
                    setSearchWord: _setSearchWord,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: SearchKeyWords(_setSearchWord)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list),
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
                else
                  Expanded(
                    child: ChatGPTSearchResult(
                      searchWord: _searchWord!,
                      textToSpeech: _textToSpeech,
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
