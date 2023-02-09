import 'dart:io';

import '../entities/user_information.dart';
import '../repositories/account_repository.dart';

class SignUpWithEmailAndPasswordUsecase {
  final AccountRepository repository;

  SignUpWithEmailAndPasswordUsecase(this.repository);

  Future<UserInformation> call(
    UserInformation userInformation,
    File? image,
    String password,
  ) =>
      repository.signUpWithEmailAndPassword(userInformation, image, password);
}
