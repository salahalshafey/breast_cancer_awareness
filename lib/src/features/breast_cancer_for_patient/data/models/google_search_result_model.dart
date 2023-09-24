import '../../domain/entities/google_search_result.dart';

class GoogleSearchResultModel extends GoogleSearchResult {
  GoogleSearchResultModel({
    required super.title,
    required super.link,
    required super.snippet,
  });

  factory GoogleSearchResultModel.fromJson(Map<String, dynamic> json) {
    return GoogleSearchResultModel(
      title: json["title"],
      link: json["link"],
      snippet: json["snippet"],
    );
  }
}
