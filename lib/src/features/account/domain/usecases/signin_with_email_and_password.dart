import '../entities/user_information.dart';
import '../repositories/account_repository.dart';

class SignInWithEmailAndPasswordUsecase {
  final AccountRepository repository;

  SignInWithEmailAndPasswordUsecase(this.repository);

  Future<UserInformation> call(String email, String password) =>
      repository.signInWithEmailAndPassword(email, password);
}
