import 'dart:io';

import '../entities/user_information.dart';
import '../repositories/account_repository.dart';

class SendUserImageAndTypeUseCase {
  final AccountRepository repository;

  SendUserImageAndTypeUseCase(this.repository);

  Future<String?> call(File? image, UserTypes? userType) =>
      repository.sendUserImageAndType(image, userType);
}
