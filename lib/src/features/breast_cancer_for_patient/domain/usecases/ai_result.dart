import '../repositories/search_repositories.dart';

class AIResultUsecase {
  final SearchRepository repository;

  const AIResultUsecase(this.repository);

  Future<String> call(String message) => repository.aiResult(message);
}
