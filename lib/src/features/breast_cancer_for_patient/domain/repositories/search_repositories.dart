import '../entities/search_result.dart';
import '../entities/search_types.dart';

abstract class SearchRepository {
  Future<List<SearchResult>> customWebSearch(
    String query,
    int numOfResult, {
    required SearchTypes searchType,
  });

  Future<String> aiResult(String message);
}
