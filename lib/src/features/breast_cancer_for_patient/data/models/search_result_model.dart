import '../../domain/entities/search_result.dart';

class SearchResultModel extends SearchResult {
  const SearchResultModel({
    required super.link,
    required super.title,
    required super.snippet,
    required super.image,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      link: json["link"],
      title: json["title"],
      snippet: json["snippet"],
      image: json["image"],
    );
  }
}
