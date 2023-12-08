import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import '../models/search_result_model.dart';

abstract class WikipediaSearch {
  Future<List<SearchResultModel>> searchResult(
    String query,
    int numOfResult,
  );
}

class WikipediaScrappingImpl implements WikipediaSearch {
  @override
  Future<List<SearchResultModel>> searchResult(
      String query, int numOfResult) async {
    try {
      final isFirstCharArabic = firstCharIsArabic(query);

      final searchKey = query.split(RegExp(r" +")).join("+");
      final breastCancer = isFirstCharArabic ? "سرطان+الثدي" : "Breast+Cancer";
      final lang = isFirstCharArabic ? "ar" : "en";
      final searchHeaderTitle = isFirstCharArabic
          ? "%D8%AE%D8%A7%D8%B5%3A%D8%A8%D8%AD%D8%AB"
          : "Special:Search";

      final url = Uri.parse(
          'https://$lang.wikipedia.org/w/index.php?search=$searchKey+%22$breastCancer%22&title=$searchHeaderTitle&profile=advanced&fulltext=1&ns0=1');

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw ServerException();
      }

      final html = dom.Document.html(response.body);

      final urls = html
          .querySelectorAll("div.mw-search-result-heading > a")
          .map((element) => element.attributes['href']!)
          .map((link) => url.toString().substring(0, 24) + link)
          .toList();

      final titles = html
          .querySelectorAll("div.mw-search-result-heading > a")
          .map((element) => element.text)
          .toList();

      final sinpts = html
          .querySelectorAll("div.searchresult")
          .map((element) => element.text)
          .toList();

      final result = <SearchResultModel>[];
      for (int i = 0; (i < urls.length) && (i < numOfResult); i++) {
        result.add(
          SearchResultModel(
            link: urls[i],
            title: titles[i],
            snippet: sinpts[i],
          ),
        );
      }

      return result;
    } catch (error) {
      throw ServerException();
    }
  }
}
