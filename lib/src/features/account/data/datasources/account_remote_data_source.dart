import '../../../../core/error/exceptions_without_message.dart';
import '../models/user_information_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AccountRemoteDataSource {
  Future<UserInformationModel> getUser(String userId);

  Future<void> addUser(UserInformationModel user);

  Future<void> storeUserImageAndType(
      String userId, String? imageUrl, String userType);

  Future<void> deleteUserData(String userId);
}

class AccountFirestoreImpl implements AccountRemoteDataSource {
  AccountFirestoreImpl();

  @override
  Future<UserInformationModel> getUser(String userId) async {
    try {
      final document = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (document.data() == null) {
        throw EmptyDataException();
      }

      return UserInformationModel.fromFirestore(document.data()!, document.id);
    } on EmptyDataException {
      rethrow;
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<void> addUser(UserInformationModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toFirestore());
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<void> storeUserImageAndType(
      String userId, String? imageUrl, String userType) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'image_url': imageUrl,
          'user_type': userType,
        },
      );
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteUserData(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    } catch (error) {
      throw ServerException();
    }
  }
}
