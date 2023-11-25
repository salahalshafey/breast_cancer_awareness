import 'dart:io';

import '../entities/user_information.dart';
import '../repositories/account_repository.dart';

class AddOrUpdateUserDataUsecase {
  final AccountRepository repository;

  AddOrUpdateUserDataUsecase(this.repository);

  Future<UserInformation> call(
    UserInformation userInformation,
    File? image, {
    bool imageUpdated = true,
  }) =>
      repository.addOrUpdateUserData(
        userInformation,
        image,
        imageUpdated: imageUpdated,
      );
}
