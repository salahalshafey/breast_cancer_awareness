import '../../../../core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountRemoteAuthentication {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> signUpWithEmailAndPassword(String email, String password);
}

class AccountFirebaseAuthenticationImpl implements AccountRemoteAuthentication {
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
      } else {
        throw EmailNotValidException();
      }
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<String> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else {
        throw EmailNotValidException();
      }
    } catch (error) {
      throw ServerException();
    }
  }
}
