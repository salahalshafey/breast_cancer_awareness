import 'dart:io';

import '../entities/user_information.dart';

abstract class AccountRepository {
  Future<UserInformation> getUserInformation(String userId);

  Future<UserInformation> signInWithEmailAndPassword(
      String email, String password);

  Future<UserInformation> signUpWithEmailAndPassword(
      UserInformation userInformation, String password);

  Future<String?> sendUserImageAndType(File? image, String userType);
}
