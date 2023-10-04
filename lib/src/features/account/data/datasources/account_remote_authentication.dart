import '../../../../core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountRemoteAuthentication {
  Future<String> signInAnonymously();
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<User> signUpWithEmailAndPassword(String email, String password);
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
}
