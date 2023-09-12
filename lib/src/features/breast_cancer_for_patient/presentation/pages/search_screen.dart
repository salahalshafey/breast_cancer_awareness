import 'package:flutter/material.dart';

import '../../../../core/util/widgets/default_screen.dart';
import '../widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _searchWord;
  final _controller = TextEditingController();

  void _setSearchWord(String searchword) {
    setState(() {
      _searchWord = searchword;
    });

    _controller.text = searchword;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingAppBar: false,
      containingBackgroundCancerSympol: false,
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
            padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: SearchField(
                    controller: _controller,
                    setSearchWord: _setSearchWord,
                  ),
                ),
                const SizedBox(height: 20),
                const Text("some search keyword"),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      // SizedBox(height: 20),
                      _searchWord == null
                          ? const Text("image for searching")
                          : Text(
                              "search results for $_searchWord ..... \n\n" * 20,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromRGBO(199, 40, 107, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                    ], //.animate(interval: 100.ms).fade().moveX(),
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

extension on String {
  String operator *(int num) {
    String res = "";
    for (int i = 0; i < num; i++) {
      res += this;
    }
    return res;
  }
}
