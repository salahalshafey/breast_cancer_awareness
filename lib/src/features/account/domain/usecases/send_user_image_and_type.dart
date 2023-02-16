import 'dart:io';

import '../repositories/account_repository.dart';

class SendUserImageAndTypeUseCase {
  final AccountRepository repository;

  SendUserImageAndTypeUseCase(this.repository);

  Future<String?> call(File? image, String userType) =>
      repository.sendUserImageAndType(image, userType);
}
