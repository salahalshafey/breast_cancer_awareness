import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import '../models/google_search_result_model.dart';

abstract class GoogleSearch {
  Future<List<GoogleSearchResultModel>> searchResult(
    String query,
    int numOfResult,
  );
}

class GoogleScholarScrappingImpl implements GoogleSearch {
  @override
  Future<List<GoogleSearchResultModel>> searchResult(
    String query,
    int numOfResult,
  ) async {
    try {
      final searchKey = query.split(RegExp(r" +")).join("+");
      final breastCancer =
          firstCharIsArabic(query) ? "سرطان+الثدي" : "Breast+Cancer";

      final url = Uri.parse(
          'https://scholar.google.com.eg/scholar?q=$searchKey+%22$breastCancer%22&hl=en&as_sdt=0&as_vis=1&oi=scholart');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw ServerException();
      }

      final html = dom.Document.html(response.body);

      final urls = html
          .querySelectorAll("h3.gs_rt > a")
          .map((element) => element.attributes['href']!)
          .toList();

      final titles = html
          .querySelectorAll("h3.gs_rt > a")
          .map((element) => element.text)
          .toList();

      final sinpts = html
          .querySelectorAll("div.gs_rs")
          .map((element) => element.text)
          .toList();

      final result = <GoogleSearchResultModel>[];
      for (int i = 0; (i < urls.length) && (i < numOfResult); i++) {
        result.add(
          GoogleSearchResultModel(
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

class HerokuappImpl implements GoogleSearch {
  @override
  Future<List<GoogleSearchResultModel>> searchResult(
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

    return results
        .map((result) => GoogleSearchResultModel.fromJson(result))
        .toList();
  }
}
