import '../entities/google_search_result.dart';

abstract class SearchRepository {
  Future<List<GoogleSearchResult>> customGoogleSearch(
    String query,
    int numOfResult,
  );

  Future<String> aiResult(String message);
}
