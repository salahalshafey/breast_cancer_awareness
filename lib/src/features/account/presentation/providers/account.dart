// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../../../dispose_container.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/user_information.dart';

import '../../domain/usecases/add_or_update_user_data.dart';
import '../../domain/usecases/get_user_information.dart';
import '../../domain/usecases/send_user_image_and_type.dart';
import '../../domain/usecases/sign_in_anonymously.dart';
import '../../domain/usecases/signin_with_email_and_password.dart';
import '../../domain/usecases/signup_with_email_and_password.dart';

import 'api_keys.dart';

class Account extends DisposableProvider {
  final GetUserInformationUsecase getUserInformationUseCase;
  final SignInAnonymouslyUsecase signUserInAnonymouslyUseCase;
  final SignInWithEmailAndPasswordUsecase
      signUserInUsingEmailAndPasswordUseCase;
  final SignUpWithEmailAndPasswordUsecase
      signUserUpUsingEmailAndPasswordUseCase;
  final SendUserImageAndTypeUseCase sendUserImageAndTypeUseCase;
  final AddOrUpdateUserDataUsecase addOrApdateUserDataUsecase;

  Account({
    required this.getUserInformationUseCase,
    required this.signUserInAnonymouslyUseCase,
    required this.signUserInUsingEmailAndPasswordUseCase,
    required this.signUserUpUsingEmailAndPasswordUseCase,
    required this.sendUserImageAndTypeUseCase,
    required this.addOrApdateUserDataUsecase,
  });

  UserInformation? _userInfo;
  bool _userFetchedFromBackend = false;

  String get userId => FirebaseAuth.instance.currentUser!.isAnonymous
      ? "guest"
      : FirebaseAuth.instance.currentUser!.uid;

  Future<UserInformation?> getUserInfo() async {
    if (!_userFetchedFromBackend) {
      try {
        await updateAndGetUserInfo();
      } catch (error) {
        rethrow;
      }
    }

    return _userInfo;
  }

  Future<void> updateAndGetUserInfo() async {
    try {
      _userInfo = await getUserInformationUseCase.call(userId);
      _userFetchedFromBackend = true;
      notifyListeners();
    } on OfflineException {
      throw Error('You are currently offline.');
    } on ServerException {
      throw Error('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw Error("Error happend, There is no data for that Account");
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<void> signInAnonymously() async {
    try {
      _userInfo = await signUserInAnonymouslyUseCase.call();
      _userFetchedFromBackend = true;
      notifyListeners();
    } on OfflineException {
      throw Error('You are currently offline.');
    } on ServerException {
      throw Error('Something went wrong, please try again later.');
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<void> signInUsingEmailAndPassword(
      String email, String password) async {
    try {
      _userInfo =
          await signUserInUsingEmailAndPasswordUseCase.call(email, password);
      _userFetchedFromBackend = true;
      notifyListeners();
    } on OfflineException {
      throw Error('You are currently offline.');
    } on ServerException {
      throw Error('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw Error("Error happend, There is no data for that user");
    } on UserNotFoundException {
      throw Error("User not found for that email.");
    } on EmailNotValidException {
      throw Error("Email Not Valid.");
    } on WrongPasswordException {
      throw Error("The password is wrong.");
    } on UserNotFoundOrWrongPasswordException {
      throw Error(
          "The User is not found for that email OR The password is wrong.");
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

  Future<UserCredential> signInWithGoogle() async {
    if (await NetworkInfoImpl().isNotConnected) {
      throw Error('You are currently offline.');
    }

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw Error("No Google account was selected!!!");
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException {
      throw Error('Something went wrong, please try again later.');
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    if (await NetworkInfoImpl().isNotConnected) {
      throw Error('You are currently offline.');
    }

    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      throw Error("No Facebook account was selected!!!");
    }

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    try {
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        throw Error(
            "An account already exists with the same email address as your Facebook account.\n"
            "Sign in using the account that is associated with this email address.");
      }

      throw Error('Something went wrong, please try again later.');
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<UserCredential> signInWithTwitter() async {
    if (await NetworkInfoImpl().isNotConnected) {
      throw Error('You are currently offline.');
    }

    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
      apiKey: TwitterConfig.apiKey,
      apiSecretKey: TwitterConfig.apiSecretKey,
      redirectURI: "breast-cancer-awareness-9b69e://",
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    if (authResult.authToken == null) {
      throw Error("No X account was selected!!!");
    }

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    try {
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        throw Error(
            "An account already exists with the same email address as your X account.\n"
            "Sign in using the account that is associated with this email address.");
      }

      throw Error('Something went wrong, please try again later.');
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

  Future<void> addOrUpdateUserData(
      UserInformation userInformation, File? image) async {
    try {
      _userInfo = await addOrApdateUserDataUsecase.call(userInformation, image);
      _userFetchedFromBackend = true;

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

  void signOut(BuildContext context) {
    final providerData = FirebaseAuth.instance.currentUser!.providerData;

    if (providerData.isEmpty) {
      FirebaseAuth.instance.signOut(); // facebook.com

      AppProviders.disposeAllDisposableProviders(context);

      return;
    }

    final providerId = providerData.first.providerId;

    if (providerId == "google.com") {
      GoogleSignIn().disconnect();
      GoogleSignIn().signOut();
    } else if (providerId == "facebook.com") {
      FacebookAuth.instance.logOut();
    }

    FirebaseAuth.instance.signOut(); // facebook.com

    AppProviders.disposeAllDisposableProviders(context);
  }

  @override
  void disposeValues() {
    _userInfo = null;
    _userFetchedFromBackend = false;
  }
}
