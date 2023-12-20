// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app.dart';
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

  final _context = navigatorKey.currentContext!;

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
      throw ErrorMessage(AppLocalizations.of(_context)!.youAreCurrentlyOffline);
    } on ServerException {
      throw ErrorMessage(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } on EmptyDataException {
      throw ErrorMessage(AppLocalizations.of(_context)!
          .errorHappendThereIsNoDataForThatAccount);
    } catch (error) {
      throw ErrorMessage(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
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
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.youAreCurrentlyOffline);
    } on ServerException {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
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
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.youAreCurrentlyOffline);
    } on ServerException {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } on EmptyDataException {
      throw ErrorForDialog(AppLocalizations.of(_context)!
          .errorHappendThereIsNoDataForThatAccount);
    } on UserNotFoundException {
      throw ErrorForEmailTextField(
          AppLocalizations.of(_context)!.userNotFoundForThatEmail);
    } on EmailNotValidException {
      throw ErrorForEmailTextField(
          AppLocalizations.of(_context)!.emailNotValid);
    } on WrongPasswordException {
      throw ErrorForPasswordTextField(
          AppLocalizations.of(_context)!.thePasswordIsWrong);
    } on UserNotFoundOrWrongPasswordException {
      throw ErrorForDialog(AppLocalizations.of(_context)!
          .theUserIsNotFoundForThatEmailOrThePasswordIsWrong);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
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
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.youAreCurrentlyOffline);
    } on ServerException {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } on EmptyDataException {
      throw ErrorForDialog(AppLocalizations.of(_context)!
          .errorHappendThereIsNoDataForThatAccount);
    } on WeakPasswordException {
      throw ErrorForPasswordTextField(AppLocalizations.of(_context)!
          .theProvidedPasswordIsWeakTryToPutAStrongPassword);
    } on EmailAlreadyInUseException {
      throw ErrorForEmailTextField(AppLocalizations.of(_context)!
          .theProvidedEmailAlreadyExistsSignInInsteadOrProvideAnotherEmail);
    } on EmailNotValidException {
      throw ErrorForEmailTextField(
          AppLocalizations.of(_context)!.emailNotValid);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
    }
  }

  ///////////////////////// Google Login //////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future<OAuthCredential> _getGoogleCredential() async {
    if (await MyNetworkInfoImpl().isNotConnected) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.youAreCurrentlyOffline);
    }

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw ErrorForSnackBar(AppLocalizations.of(_context)!
          .noProviderNameAccountWasSelected(
              AppLocalizations.of(_context)!.google));
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
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
    }
  }

  ///////////////////////// Facebook Login ////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future<OAuthCredential> _getFacebookCredential() async {
    if (await MyNetworkInfoImpl().isNotConnected) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.youAreCurrentlyOffline);
    }

    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      throw ErrorForSnackBar(AppLocalizations.of(_context)!
          .noProviderNameAccountWasSelected(
              AppLocalizations.of(_context)!.facebook));
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
        throw ErrorForDialog(AppLocalizations.of(_context)!
            .anAccountAlreadyExistsWithTheSameEmailAddressAsYourProviderAccount(
                AppLocalizations.of(_context)!.facebook));
      }

      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
    }
  }

  ///////////////////////// Twitter Login /////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future<OAuthCredential> _getTwitterCredential() async {
    if (await MyNetworkInfoImpl().isNotConnected) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.youAreCurrentlyOffline);
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
      throw ErrorForSnackBar(AppLocalizations.of(_context)!
          .noProviderNameAccountWasSelected(
              AppLocalizations.of(_context)!.twitter));
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
        throw ErrorForDialog(AppLocalizations.of(_context)!
            .anAccountAlreadyExistsWithTheSameEmailAddressAsYourProviderAccount(
                AppLocalizations.of(_context)!.twitter));
      }

      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
    }
  }

  //////////////// reauthenticate With Password OR Social /////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future<void> reauthenticateWithPasswordCredential(String password) async {
    if (await MyNetworkInfoImpl().isNotConnected) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.youAreCurrentlyOffline);
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
        throw ErrorForPasswordTextField(
            AppLocalizations.of(_context)!.thePasswordIsWrong);
      }

      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
    }
  }

  Future<void> reauthenticateWithSocialCredential(String providerId) async {
    final providerName = providerId == "google.com"
        ? AppLocalizations.of(_context)!.google
        : providerId == "facebook.com"
            ? AppLocalizations.of(_context)!.facebook
            : AppLocalizations.of(_context)!.twitter;

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
          AppLocalizations.of(_context)!
              .youSelectedADifferentProviderAccount(providerName),
        );
      }

      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
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
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.youAreCurrentlyOffline);
    } on ServerException {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } on EmptyDataException {
      throw ErrorForDialog(AppLocalizations.of(_context)!
          .errorHappendThereIsNoDataForThatAccount);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
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
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.youAreCurrentlyOffline);
    } on ServerException {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } on EmptyDataException {
      throw ErrorForDialog(AppLocalizations.of(_context)!
          .errorHappendThereIsNoDataForThatAccount);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
    }
  }

  Future<void> deleteEveryThingToCurrentUser() async {
    try {
      await deleteEveryThingToCurrentUserUsecase.call();
    } on OfflineException {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.youAreCurrentlyOffline);
    } on ServerException {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.somethingWentWrongPleaseTryAgainLater);
    } catch (error) {
      throw ErrorForDialog(
          AppLocalizations.of(_context)!.unexpectedErrorHappened);
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
