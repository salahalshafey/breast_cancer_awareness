import '../entities/user_information.dart';
import '../repositories/account_repository.dart';

class SignUpWithEmailAndPasswordUsecase {
  final AccountRepository repository;

  SignUpWithEmailAndPasswordUsecase(this.repository);

  Future<UserInformation> call(
    UserInformation userInformation,
    String password,
  ) =>
      repository.signUpWithEmailAndPassword(userInformation, password);
}
