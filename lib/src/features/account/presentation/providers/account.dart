// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../../../core/error/error_exceptions_with_message.dart';
import '../../../../dispose_container.dart';

import '../../../../core/error/exceptions_without_message.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/user_information.dart';

import '../../domain/usecases/add_or_update_user_data.dart';
import '../../domain/usecases/delete_every_thing_to_current_user_use_case.dart';
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
  final DeleteEveryThingToCurrentUserUsecase
      deleteEveryThingToCurrentUserUsecase;

  Account({
    required this.getUserInformationUseCase,
    required this.signUserInAnonymouslyUseCase,
    required this.signUserInUsingEmailAndPasswordUseCase,
    required this.signUserUpUsingEmailAndPasswordUseCase,
    required this.sendUserImageAndTypeUseCase,
    required this.addOrApdateUserDataUsecase,
    required this.deleteEveryThingToCurrentUserUsecase,
  });

  UserInformation? _userInfo;
  bool _userFetchedFromBackend = false;
  String? _providerId;

  ////////////////////////// get OR refresh user data ////////////////////////
  ///////////////////////////////////////////////////////////////////////////

  String get userId => FirebaseAuth.instance.currentUser!.isAnonymous
      ? "guest"
      : FirebaseAuth.instance.currentUser!.uid;

  Future<UserInformation?> getUserInfo() async {
    final providerData = FirebaseAuth.instance.currentUser!.providerData;
    if (providerData.isNotEmpty) {
      _providerId = providerData.first.providerId;
    }

    if (!_userFetchedFromBackend) {
      try {
        await refreshAndGetUserInfo();
      } catch (error) {
        rethrow;
      }
    }

    return _userInfo;
  }

  Future<void> refreshAndGetUserInfo() async {
    try {
      _userInfo = await getUserInformationUseCase.call(userId);
      _userFetchedFromBackend = true;
      notifyListeners();
    } on OfflineException {
      throw ErrorForDialog('You are currently offline.');
    } on ServerException {
      throw ErrorForDialog('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw ErrorForDialog("Error happend, There is no data for that Account");
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  ////////////////////////// Sign In/Up/Anonymously ///////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future<void> signInAnonymously() async {
    try {
      _userInfo = await signUserInAnonymouslyUseCase.call();
      _userFetchedFromBackend = true;
      notifyListeners();
    } on OfflineException {
      throw ErrorForDialog('You are currently offline.');
    } on ServerException {
      throw ErrorForDialog('Something went wrong, please try again later.');
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
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
      throw ErrorForDialog('You are currently offline.');
    } on ServerException {
      throw ErrorForDialog('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw ErrorForDialog("Error happend, There is no data for that user");
    } on UserNotFoundException {
      throw ErrorForDialog("User not found for that email.");
    } on EmailNotValidException {
      throw ErrorForDialog("Email Not Valid.");
    } on WrongPasswordException {
      throw ErrorForDialog("The password is wrong.");
    } on UserNotFoundOrWrongPasswordException {
      throw ErrorForDialog(
          "The User is not found for that email OR The password is wrong.");
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
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
      throw ErrorForDialog('You are currently offline.');
    } on ServerException {
      throw ErrorForDialog('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw ErrorForDialog("Error happend, There is no data for that user");
    } on WeakPasswordException {
      throw ErrorForDialog(
          "The provided password is weak try to put a strong password.");
    } on EmailAlreadyInUseException {
      throw ErrorForDialog(
          "The provided email already exists, sign in instead or provide another email.");
    } on EmailNotValidException {
      throw ErrorForDialog("Email Not Valid.");
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  ///////////////////////// Google Login //////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future<OAuthCredential> _getGoogleCredential() async {
    if (await NetworkInfoImpl().isNotConnected) {
      throw ErrorForDialog('You are currently offline.');
    }

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw ErrorForDialog("No Google account was selected!!!");
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return credential;
  }

  Future<UserCredential> signInWithGoogle() async {
    final credential = await _getGoogleCredential();

    try {
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException {
      throw ErrorForDialog('Something went wrong, please try again later.');
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  ///////////////////////// Facebook Login ////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future<OAuthCredential> _getFacebookCredential() async {
    if (await NetworkInfoImpl().isNotConnected) {
      throw ErrorForDialog('You are currently offline.');
    }

    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      throw ErrorForDialog("No Facebook account was selected!!!");
    }

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return facebookAuthCredential;
  }

  Future<UserCredential> signInWithFacebook() async {
    final facebookAuthCredential = await _getFacebookCredential();

    try {
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        throw ErrorForDialog(
            "An account already exists with the same email address as your **Facebook** account.\n"
            "Sign in using the account that is associated with this email address.");
      }

      throw ErrorForDialog('Something went wrong, please try again later.');
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  ///////////////////////// Twitter Login /////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future<OAuthCredential> _getTwitterCredential() async {
    if (await NetworkInfoImpl().isNotConnected) {
      throw ErrorForDialog('You are currently offline.');
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
      throw ErrorForDialog("No X account was selected!!!");
    }

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    return twitterAuthCredential;
  }

  Future<UserCredential> signInWithTwitter() async {
    final twitterAuthCredential = await _getTwitterCredential();

    try {
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        throw ErrorForDialog(
            "An account already exists with the same email address as your **X** account.\n"
            "Sign in using the account that is associated with this email address.");
      }

      throw ErrorForDialog('Something went wrong, please try again later.');
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  //////////////// reauthenticate With Password OR Social /////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future<void> reauthenticateWithPasswordCredential(String password) async {
    if (await NetworkInfoImpl().isNotConnected) {
      throw ErrorForDialog('You are currently offline.');
    }

    try {
      final currentUser = FirebaseAuth.instance.currentUser!;
      await currentUser.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: currentUser.providerData.first.email!,
          password: password,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        throw ErrorForDialog("The password is wrong.");
      }

      throw ErrorForDialog('Something went wrong, please try again later.');
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  Future<void> reauthenticateWithSocialCredential(String providerId) async {
    final providerName = providerId == "google.com"
        ? "Google"
        : providerId == "facebook.com"
            ? "Facebook"
            : "X";

    late OAuthCredential socialAuthCredential;

    if (providerId == "google.com") {
      socialAuthCredential = await _getGoogleCredential();
    } else if (providerId == "facebook.com") {
      socialAuthCredential = await _getFacebookCredential();
    } else {
      socialAuthCredential = await _getTwitterCredential();
    }

    try {
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(socialAuthCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-mismatch" || e.code == "user-not-found") {
        throw ErrorForDialog(
          "You selected a different **$providerName** Account.\n"
          "select the **$providerName** Account that you logged in with the App. "
          "OR re-sign into the app instead.",
        );
      }

      throw ErrorForDialog('Something went wrong, please try again later.');
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  //////////////////// User add/update/delete/signOut /////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future<void> sendUserImageAndType(File? image, UserTypes? userType) async {
    try {
      final imageUrl = await sendUserImageAndTypeUseCase.call(image, userType);

      _userInfo = _userInfo!.copyWith(imageUrl: imageUrl, userType: userType);

      notifyListeners();
    } on OfflineException {
      throw ErrorForDialog('You are currently offline.');
    } on ServerException {
      throw ErrorForDialog('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw ErrorForDialog("Error happend, There is no data for that user");
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  Future<void> addOrUpdateUserData(
    UserInformation userInformation,
    File? image, {
    bool imageUpdated = true,
  }) async {
    try {
      _userInfo = await addOrApdateUserDataUsecase.call(
        userInformation,
        image,
        imageUpdated: imageUpdated,
      );
      _userFetchedFromBackend = true;

      notifyListeners();
    } on OfflineException {
      throw ErrorForDialog('You are currently offline.');
    } on ServerException {
      throw ErrorForDialog('Something went wrong, please try again later.');
    } on EmptyDataException {
      throw ErrorForDialog("Error happend, There is no data for that user");
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  Future<void> deleteEveryThingToCurrentUser() async {
    try {
      await deleteEveryThingToCurrentUserUsecase.call();
    } on OfflineException {
      throw ErrorForDialog('You are currently offline.');
    } on ServerException {
      throw ErrorForDialog('Something went wrong, please try again later.');
    } catch (error) {
      throw ErrorForDialog('An unexpected error happened.');
    }
  }

  void signOut(BuildContext context) {
    if (_providerId == null) {
      FirebaseAuth.instance.signOut();

      AppProviders.disposeAllDisposableProviders(context);

      return;
    }

    if (_providerId == "google.com") {
      GoogleSignIn().disconnect();
      GoogleSignIn().signOut();
    } else if (_providerId == "facebook.com") {
      FacebookAuth.instance.logOut();
    }

    FirebaseAuth.instance.signOut();

    AppProviders.disposeAllDisposableProviders(context);
  }

  @override
  void disposeValues() {
    _userInfo = null;
    _userFetchedFromBackend = false;
  }
}
