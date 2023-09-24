import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/google_search_result.dart';

import '../../domain/usecases/ai_result.dart';
import '../../domain/usecases/custom_google_search.dart';

class Search with ChangeNotifier {
  final CustomGoogleSearchUsecase customGoogleSearchUsecase;
  final AIResultUsecase aiResultUsecase;

  Search({
    required this.customGoogleSearchUsecase,
    required this.aiResultUsecase,
  });

  Future<List<GoogleSearchResult>> customGoogleSearch(String query,
      {int numOfResult = 3}) async {
    try {
      final result = await customGoogleSearchUsecase.call(query, numOfResult);

      return result;
    } on OfflineException {
      throw Error('You are currently offline.');
    } on ServerException {
      throw Error('Something went wrong, please try again later.');
    } on FilterException {
      throw Error(
          "Sorry, there is no result for your search, the result has been filtered.");
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<String> aiChatSearch(String message) async {
    try {
      final result = await aiResultUsecase.call(message);

      return result;
    } on OfflineException {
      throw Error('You are currently offline.');
    } on ServerException {
      throw Error('Something went wrong, please try again later.');
    } on FilterException {
      throw Error(
          "Sorry, there is no result for your search, the result has been filtered or it is not of our capability yet.");
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }
}
