import '../entities/google_search_result.dart';
import '../repositories/search_repositories.dart';

class CustomGoogleSearchUsecase {
  final SearchRepository repository;

  const CustomGoogleSearchUsecase(this.repository);

  Future<List<GoogleSearchResult>> call(String query, int numOfResult) =>
      repository.customGoogleSearch(query, numOfResult);
}
