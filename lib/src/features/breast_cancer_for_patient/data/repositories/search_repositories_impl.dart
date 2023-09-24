import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

import '../datasources/google_search.dart';
import '../datasources/ai_chat.dart';

import '../../domain/entities/google_search_result.dart';
import '../../domain/repositories/search_repositories.dart';

class SearchRepositoryImpl implements SearchRepository {
  final GoogleSearch googleSearch;
  final AIChat aiChat;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl({
    required this.googleSearch,
    required this.aiChat,
    required this.networkInfo,
  });

  @override
  Future<List<GoogleSearchResult>> customGoogleSearch(
      String query, int numOfResult) async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    return googleSearch.searchResult(query, numOfResult);
  }

  @override
  Future<String> aiResult(String message) async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    return aiChat.chatResult(message);
  }
}
