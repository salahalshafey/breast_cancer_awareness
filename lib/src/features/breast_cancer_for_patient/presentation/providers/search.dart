// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../app.dart';
import '../../../../../l10n/app_localizations.dart';
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

  final _context = navigatorKey.currentContext!;

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
      throw ErrorMessage(
        AppLocalizations.of(_context)!.youAreCurrentlyOffline,
      );
    } on ServerException {
      throw ErrorMessage(
        AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater,
      );
    } on FilterException {
      throw ErrorMessage(
        AppLocalizations.of(_context)!.sorryThereIsNoResultForYourSearch,
      );
    } catch (error) {
      throw ErrorMessage(
        AppLocalizations.of(_context)!.unexpectedErrorHappened,
      );
    }
  }

  Future<String> aiChatSearch(String message) async {
    try {
      final result = await aiResultUsecase.call(message);

      return result;
    } on OfflineException {
      throw ErrorMessage(
        AppLocalizations.of(_context)!.youAreCurrentlyOffline,
      );
    } on ServerException {
      throw ErrorMessage(
        AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater,
      );
    } on FilterException {
      throw ErrorMessage(
        AppLocalizations.of(_context)!
            .sorryThereIsNoResultForYourSearchWithDetails,
      );
    } catch (error) {
      throw ErrorMessage(
        AppLocalizations.of(_context)!.unexpectedErrorHappened,
      );
    }
  }
}
