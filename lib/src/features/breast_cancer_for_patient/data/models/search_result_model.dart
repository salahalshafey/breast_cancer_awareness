import '../../domain/entities/search_result.dart';

class SearchResultModel extends SearchResult {
  const SearchResultModel({
    required super.title,
    required super.link,
    required super.snippet,
    required super.imageLink,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      title: json["title"],
      link: json["link"],
      snippet: json["snippet"],
      imageLink: json["image"],
    );
  }
}
