import '../entities/search_result.dart';
import '../entities/search_types.dart';
import '../repositories/search_repositories.dart';

class CustomWebSearchUsecase {
  final SearchRepository repository;

  const CustomWebSearchUsecase(this.repository);

  Future<List<SearchResult>> call(
    String query,
    int numOfResult, {
    required SearchTypes searchType,
  }) =>
      repository.customWebSearch(query, numOfResult, searchType: searchType);
}
