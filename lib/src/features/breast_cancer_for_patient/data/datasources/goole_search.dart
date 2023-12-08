import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import '../models/search_result_model.dart';

abstract class GoogleSearch {
  Future<List<SearchResultModel>> searchResult(
    String query,
    int numOfResult,
  );
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
