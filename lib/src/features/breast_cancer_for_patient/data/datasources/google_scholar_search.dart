import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import '../../../../core/util/functions/web_utils.dart';
import '../models/search_result_model.dart';

abstract class GoogleScholarSearch {
  Future<List<SearchResultModel>> searchResult(
    String query,
    int numOfResult,
  );
}

class GoogleScholarScrappingImpl implements GoogleScholarSearch {
  @override
  Future<List<SearchResultModel>> searchResult(
    String query,
    int numOfResult,
  ) async {
    try {
      final searchKey = query.split(RegExp(r" +")).join("+");
      final breastCancer =
          firstCharIsArabic(query) ? "سرطان+الثدي" : "Breast+Cancer";

      final url = Uri.parse(
          'https://scholar.google.com.eg/scholar?q=$searchKey+%22$breastCancer%22&hl=en&as_sdt=0&as_vis=1&oi=scholart');

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

      final result = <SearchResultModel>[];
      for (int i = 0; (i < urls.length) && (i < numOfResult); i++) {
        result.add(
          SearchResultModel(
            link: urls[i],
            title: titles[i],
            snippet: sinpts[i],
            imageLink: getWebsitIconFromUrl(urls[i]),
          ),
        );
      }

      return result;
    } catch (error) {
      throw ServerException();
    }
  }
}
