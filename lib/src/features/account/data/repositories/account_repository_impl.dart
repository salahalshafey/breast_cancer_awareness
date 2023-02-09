import 'dart:io';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/user_information.dart';
import '../../domain/repositories/account_repository.dart';

import '../datasources/account_remote_data_source.dart';
import '../datasources/account_remote_storage.dart';
import '../datasources/account_remote_authentication.dart';
import '../models/user_information_model.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;
  final AccountRemoteStorage remoteStorage;
  final AccountRemoteAuthentication remoteAuth;
  final NetworkInfo networkInfo;

  AccountRepositoryImpl({
    required this.remoteDataSource,
    required this.remoteStorage,
    required this.remoteAuth,
    required this.networkInfo,
  });

  @override
  Future<UserInformation> getUserInformation(String userId) async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    return remoteDataSource.getUser(userId);
  }

  @override
  Future<UserInformation> signInWithEmailAndPassword(
      String email, String password) async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }
    try {
      final userId =
          await remoteAuth.signInWithEmailAndPassword(email, password);

      return remoteDataSource.getUser(userId);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserInformation> signUpWithEmailAndPassword(
      UserInformation userInformation, File? image, String password) async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    try {
      final userId = await remoteAuth.signUpWithEmailAndPassword(
          userInformation.email, password);

      String? downloadURL;
      if (image != null) {
        downloadURL = await remoteStorage.upload(userId, image);
      }

      userInformation = userInformation.copyWith(
        id: userId,
        imageURl: downloadURL,
        dateOfSignUp: DateTime.now(),
      );

      remoteDataSource.addUser(
        UserInformationModel(
          id: userInformation.id,
          firstName: userInformation.firstName,
          lastName: userInformation.lastName,
          email: userInformation.email,
          imageURl: userInformation.imageURl,
          dateOfSignUp: userInformation.dateOfSignUp,
          userType: userInformation.userType,
        ),
      );

      return userInformation;
    } catch (error) {
      rethrow;
    }
  }
}
