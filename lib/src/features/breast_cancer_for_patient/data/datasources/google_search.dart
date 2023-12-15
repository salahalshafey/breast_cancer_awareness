import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../../../../core/error/exceptions_without_message.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../../core/util/functions/web_utils.dart';

import '../models/search_result_model.dart';

abstract class GoogleSearch {
  Future<List<SearchResultModel>> searchResult(
    String query,
    int numOfResult,
  );
}

class GoogleSearchScrappingImpl implements GoogleSearch {
  @override
  Future<List<SearchResultModel>> searchResult(
    String query,
    int numOfResult,
  ) async {
    try {
      final searchKey = query.split(RegExp(r" +")).join("+");
      final fixedKey =
          firstCharIsArabic(query) ? "سرطان+الثدي" : "Breast+Cancer";

      final url = Uri.parse(
          'https://www.google.com.eg/search?q=$searchKey+%22$fixedKey%22');

      final headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
        'Referer': 'https://www.google.com/',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        throw ServerException();
      }

      final html = dom.Document.html(response.body);

      final targetElements =
          html.getElementsByClassName("g Ww4FFb vt6azd tF2Cxc asEBEc");

      final urls = targetElements
          .map((element) => element
              .getElementsByClassName("yuRUbf")[0]
              .children[0]
              .children[0]
              .children[0]
              .attributes['href']!)
          .toList();

      final titles = targetElements
          .map((element) => element
              .getElementsByClassName("LC20lb MBeuO DKV0Md")[0]
              .text
              .trim())
          .toList();

      final sinpts = targetElements.map((element) {
        final sniptsSpans = element
            .getElementsByClassName("VwiC3b yXK7lf lVm3ye r025kc hJNv6b")[0]
            .children;

        return sniptsSpans.length > 1
            ? sniptsSpans[1].text.trim()
            : sniptsSpans[0].text.trim();
      }).toList();

      final result = <SearchResultModel>[];
      for (int i = 0; (i < urls.length) && (i < numOfResult); i++) {
        result.add(
          SearchResultModel(
            link: urls[i],
            title: titles[i],
            snippet: sinpts[i],
            image: getWebsitIconFromUrl(urls[i]),
          ),
        );
      }

      return result;
    } catch (error) {
      throw ServerException();
    }
  }
}

class HerokuappImpl implements GoogleSearch {
  @override
  Future<List<SearchResultModel>> searchResult(
    String query,
    int numOfResult,
  ) async {
    String url = 'https://ddg-api.herokuapp.com/search';

    final breastCancer =
        firstCharIsArabic(query) ? "\"سرطان الثدي\"" : "\"Breast Cancer\"";

    Map<String, dynamic> params = {
      "query": "$query $breastCancer",
      "limit": "$numOfResult",
    };

    final uri = Uri.parse(url).replace(queryParameters: params);

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final results = jsonDecode(response.body) as List<dynamic>;

    return results.map((result) => SearchResultModel.fromJson(result)).toList();
  }
}
