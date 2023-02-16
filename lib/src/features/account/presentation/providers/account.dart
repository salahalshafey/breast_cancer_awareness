import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exceptions.dart';

import '../../domain/entities/user_information.dart';
import '../../domain/usecases/get_user_information.dart';
import '../../domain/usecases/send_user_image_and_type.dart';
import '../../domain/usecases/signin_with_email_and_password.dart';
import '../../domain/usecases/signup_with_email_and_password.dart';

class Account with ChangeNotifier {
  Account({
    required this.getUserInformationUseCase,
    required this.signUserInUsingEmailAndPasswordUseCase,
    required this.signUserUpUsingEmailAndPasswordUseCase,
    required this.sendUserImageAndTypeUseCase,
  });

  final GetUserInformationUsecase getUserInformationUseCase;
  final SignInWithEmailAndPasswordUsecase
      signUserInUsingEmailAndPasswordUseCase;
  final SignUpWithEmailAndPasswordUsecase
      signUserUpUsingEmailAndPasswordUseCase;
  final SendUserImageAndTypeUseCase sendUserImageAndTypeUseCase;

  UserInformation? _userInfo;
  bool _userFetchedFromBackend = false;

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  Future<UserInformation> getUserInfo() async {
    if (!_userFetchedFromBackend) {
      try {
        await updateAndGetUserInfo();
      } catch (error) {
        rethrow;
      }
    }

    return _userInfo!;
  }

  Future<UserInformation> updateAndGetUserInfo() async {
    try {
      _userInfo = await getUserInformationUseCase.call(userId);
      notifyListeners();
      _userFetchedFromBackend = true;

      return _userInfo!;
    } on OfflineException {
      throw Error('You are currently offline.');
    } on ServerException {
      throw Error('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw Error("Error happend, There is no data for that user");
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<void> signInUsingEmailAndPassword(
      String email, String password) async {
    try {
      _userInfo =
          await signUserInUsingEmailAndPasswordUseCase.call(email, password);
      notifyListeners();
      _userFetchedFromBackend = true;
    } on OfflineException {
      throw Error('You are currently offline.');
    } on ServerException {
      throw Error('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw Error("Error happend, There is no data for that user");
    } on UserNotFoundException {
      throw Error("User not found for that email.");
    } on WrongPasswordException {
      throw Error("The password is wrong.");
    } on EmailNotValidException {
      throw Error("Email Not Valid.");
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<void> signUpUsingEmailAndPassword(
    UserInformation userInformation,
    String password,
  ) async {
    try {
      _userInfo = await signUserUpUsingEmailAndPasswordUseCase.call(
          userInformation, password);
      notifyListeners();
      _userFetchedFromBackend = true;
    } on OfflineException {
      throw Error('You are currently offline.');
    } on ServerException {
      throw Error('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw Error("Error happend, There is no data for that user");
    } on WeakPasswordException {
      throw Error(
          "The provided password is weak try to put a strong password.");
    } on EmailAlreadyInUseException {
      throw Error(
          "The provided email already exists, sign in instead or provide another email.");
    } on EmailNotValidException {
      throw Error("Email Not Valid.");
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<void> sendUserImageAndType(File? image, String userType) async {
    try {
      final imageUrl = await sendUserImageAndTypeUseCase.call(image, userType);

      _userInfo = _userInfo!.copyWith(imageUrl: imageUrl, userType: userType);

      notifyListeners();
    } on OfflineException {
      throw Error('You are currently offline.');
    } on ServerException {
      throw Error('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw Error("Error happend, There is no data for that user");
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _userInfo = null;
    _userFetchedFromBackend = false;
  }
}
