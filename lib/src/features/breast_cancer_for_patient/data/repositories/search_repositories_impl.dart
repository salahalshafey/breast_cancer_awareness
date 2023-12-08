import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/search_types.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/repositories/search_repositories.dart';

import '../datasources/ai_chat.dart';
import '../datasources/goole_search.dart';
import '../datasources/google_scholar_search.dart';
import '../datasources/wikipedia_search.dart';

class SearchRepositoryImpl implements SearchRepository {
  final AIChat aiChat;
  final GoogleSearch googleSearch;
  final GoogleScholarSearch googleScholarSearch;
  final WikipediaSearch wikipediaSearch;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl({
    required this.aiChat,
    required this.googleSearch,
    required this.googleScholarSearch,
    required this.wikipediaSearch,
    required this.networkInfo,
  });

  @override
  Future<List<SearchResult>> customWebSearch(
    String query,
    int numOfResult, {
    required SearchTypes searchType,
  }) async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    switch (searchType) {
      case SearchTypes.google:
        return googleSearch.searchResult(query, numOfResult);

      case SearchTypes.googleScholar:
        return googleScholarSearch.searchResult(query, numOfResult);

      case SearchTypes.wikipedia:
        return wikipediaSearch.searchResult(query, numOfResult);

      case SearchTypes.ai:
        throw UnimplementedError("AI is not part of custom web search!!");
    }
  }

  @override
  Future<String> aiResult(String message) async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    return aiChat.chatResult(message);
  }
}
