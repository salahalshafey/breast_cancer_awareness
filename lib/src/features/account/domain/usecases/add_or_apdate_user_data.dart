import 'dart:io';

import '../entities/user_information.dart';
import '../repositories/account_repository.dart';

class AddOrApdateUserDataUsecase {
  final AccountRepository repository;

  AddOrApdateUserDataUsecase(this.repository);

  Future<UserInformation> call(
    UserInformation userInformation,
    File? image,
  ) =>
      repository.addOrApdateUserData(userInformation, image);
}
