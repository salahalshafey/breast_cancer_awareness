import '../entities/user_information.dart';
import '../repositories/account_repository.dart';

class SignInAnonymouslyUsecase {
  final AccountRepository repository;

  SignInAnonymouslyUsecase(this.repository);

  Future<UserInformation> call() => repository.signInAnonymously();
}
