import 'package:flutter/material.dart';

import '../pages/search_screen.dart';

class SearchTypeChoices extends StatelessWidget {
  const SearchTypeChoices({
    super.key,
    required this.searchType,
    required this.setSearchType,
  });

  final SearchTypes searchType;
  final void Function(SearchTypes searchType) setSearchType;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SearchTypes>(
      icon: const Icon(Icons.filter_list),
      tooltip: "Sellect search type",
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      itemBuilder: (context) {
        return [
          PopupMenuItem<SearchTypes>(
            value: SearchTypes.ai,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/ai.png", height: 20),
                    const SizedBox(width: 20),
                    Text(
                      "Ask AI",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                searchType == SearchTypes.ai
                    ? const Icon(Icons.check)
                    : const SizedBox(),
              ],
            ),
          ),
          PopupMenuItem<SearchTypes>(
            value: SearchTypes.google,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/google.png", height: 20),
                    const SizedBox(width: 20),
                    Text(
                      "Google Search",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                searchType == SearchTypes.google
                    ? const Icon(Icons.check)
                    : const SizedBox(),
              ],
            ),
          ),
        ];
      },
      onSelected: setSearchType,
    );
  }
}
