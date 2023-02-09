import '../../../../core/error/exceptions.dart';
import '../models/user_information_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AccountRemoteDataSource {
  Future<UserInformationModel> getUser(String userId);
  Future<void> addUser(UserInformationModel user);
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
}
