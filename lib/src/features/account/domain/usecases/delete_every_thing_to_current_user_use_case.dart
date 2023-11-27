import '../repositories/account_repository.dart';

class DeleteEveryThingToCurrentUserUsecase {
  final AccountRepository repository;

  DeleteEveryThingToCurrentUserUsecase(this.repository);

  Future<void> call() => repository.deleteEveryThingToCurrentUser();
}
