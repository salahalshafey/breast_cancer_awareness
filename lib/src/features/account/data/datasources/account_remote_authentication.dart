import '../../../../core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_information.dart';

abstract class AccountRemoteAuthentication {
  Future<String> signInAnonymously();
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<User> signUpWithEmailAndPassword(String email, String password);
  UserInformation getCurrentUserAuthInfo();
}

class AccountFirebaseAuthenticationImpl implements AccountRemoteAuthentication {
  @override
  Future<String> signInAnonymously() async {
    try {
      final credential = await FirebaseAuth.instance.signInAnonymously();

      return credential.user!.uid;
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else if (e.code == 'invalid-email') {
        throw EmailNotValidException();
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw UserNotFoundOrWrongPasswordException();
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else if (e.code == 'invalid-email') {
        throw EmailNotValidException();
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  UserInformation getCurrentUserAuthInfo() {
    final currentUser = FirebaseAuth.instance.currentUser!;

    if (currentUser.providerData.isNotEmpty) {
      final authUserInfo = currentUser.providerData.first;

      return UserInformation(
        id: currentUser.uid,
        firstName: _getFirstName(authUserInfo.displayName),
        lastName: _getLastName(authUserInfo.displayName),
        email: authUserInfo.email ?? "",
        phoneNumber: authUserInfo.phoneNumber == null ||
                authUserInfo.phoneNumber!.isEmpty
            ? null
            : authUserInfo.phoneNumber,
        imageUrl: authUserInfo.photoURL,
        dateOfSignUp: currentUser.metadata.creationTime!,
        userType: UserTypes.normal,
      );
    }

    return UserInformation(
      id: currentUser.uid,
      firstName: _getFirstName(currentUser.displayName),
      lastName: _getLastName(currentUser.displayName),
      email: currentUser.email ?? "",
      phoneNumber:
          currentUser.phoneNumber == null || currentUser.phoneNumber!.isEmpty
              ? null
              : currentUser.phoneNumber,
      imageUrl: currentUser.photoURL,
      dateOfSignUp: currentUser.metadata.creationTime!,
      userType: UserTypes.normal,
    );
  }

  String _getFirstName(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return "";
    }

    return displayName.split(RegExp(r" +")).first;
  }

  String _getLastName(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return "";
    }

    return displayName.split(RegExp(r" +")).sublist(1).join(" ");
  }
}
