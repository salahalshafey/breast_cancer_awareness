import 'package:flutter/material.dart';

import '../../../../core/error/error_exceptions_with_message.dart';
import '../../../../core/error/exceptions_without_message.dart';
import '../../domain/entities/search_result.dart';

import '../../domain/entities/search_types.dart';
import '../../domain/usecases/ai_result.dart';
import '../../domain/usecases/custom_web_search.dart';

class Search with ChangeNotifier {
  final CustomWebSearchUsecase customWebSearchUsecase;
  final AIResultUsecase aiResultUsecase;

  Search({
    required this.customWebSearchUsecase,
    required this.aiResultUsecase,
  });

  Future<List<SearchResult>> customWebSearch(
    String query, {
    int numOfResult = 3,
    required SearchTypes searchType,
  }) async {
    try {
      final result = await customWebSearchUsecase.call(
        query,
        numOfResult,
        searchType: searchType,
      );

      return result;
    } on OfflineException {
      throw ErrorForDialog('You are currently offline.');
    } on ServerException {
      throw ErrorForDialog('Something went wrong, please try again later.');
    } on FilterException {
      throw ErrorForDialog(
          "Sorry, there is no result for your search, the result has been filtered.");
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  Future<String> aiChatSearch(String message) async {
    try {
      final result = await aiResultUsecase.call(message);

      return result;
    } on OfflineException {
      throw ErrorForDialog('You are currently offline.');
    } on ServerException {
      throw ErrorForDialog('Something went wrong, please try again later.');
    } on FilterException {
      throw ErrorForDialog(
          "Sorry, there is no result for your search, the result has been filtered or it is not of our capability yet.");
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }
}
