import 'dart:io';

import '../entities/user_information.dart';

abstract class AccountRepository {
  Future<UserInformation> getUserInformation(String userId);

  Future<UserInformation> signInAnonymously();

  Future<UserInformation> signInWithEmailAndPassword(
      String email, String password);

  Future<UserInformation> signUpWithEmailAndPassword(
      UserInformation userInformation, String password);

  Future<String?> sendUserImageAndType(File? image, UserTypes? userType);

  Future<UserInformation> addOrUpdateUserData(
    UserInformation userInformation,
    File? image, {
    bool imageUpdated = true,
  });

  Future<void> deleteEveryThingToCurrentUser();
}
