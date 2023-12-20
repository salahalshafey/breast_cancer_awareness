import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/search_types.dart';

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
      tooltip: AppLocalizations.of(context)!.selectSearchType,
      constraints: const BoxConstraints(
        minWidth: 2.0 * 56.0,
        maxWidth: 300,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      itemBuilder: (context) {
        return [
          PopupMenuItem<SearchTypes>(
            value: SearchTypes.ai,
            child: Row(
              children: [
                Image.asset("assets/images/ai.png", height: 20),
                const SizedBox(width: 20),
                Text(
                  AppLocalizations.of(context)!.askAi,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                searchType == SearchTypes.ai
                    ? const Icon(Icons.check)
                    : const SizedBox(),
              ],
            ),
          ),
          PopupMenuItem<SearchTypes>(
            value: SearchTypes.google,
            child: Row(
              children: [
                Image.asset("assets/images/google.png", height: 20),
                const SizedBox(width: 20),
                Text(
                  AppLocalizations.of(context)!.googleSearch,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                searchType == SearchTypes.google
                    ? const Icon(Icons.check)
                    : const SizedBox(),
              ],
            ),
          ),
          PopupMenuItem<SearchTypes>(
            value: SearchTypes.googleScholar,
            child: Row(
              children: [
                Image.asset("assets/images/google_scholar.png", height: 20),
                const SizedBox(width: 20),
                Text(
                  AppLocalizations.of(context)!.googleScholar,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                searchType == SearchTypes.googleScholar
                    ? const Icon(Icons.check)
                    : const SizedBox(),
              ],
            ),
          ),
          PopupMenuItem<SearchTypes>(
            value: SearchTypes.wikipedia,
            child: Row(
              children: [
                Image.asset("assets/images/wikipedia.png", height: 20),
                const SizedBox(width: 20),
                Text(
                  AppLocalizations.of(context)!.wikipediaSearch,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                searchType == SearchTypes.wikipedia
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
