import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exceptions_without_message.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/user_information.dart';
import '../../domain/repositories/account_repository.dart';

import '../datasources/account_remote_data_source.dart';
import '../datasources/account_local_data_source.dart';
import '../datasources/account_remote_storage.dart';
import '../datasources/account_remote_authentication.dart';
import '../models/user_information_model.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;
  final AccountLocalDataSource localDataSource;
  final AccountRemoteStorage remoteStorage;
  final AccountRemoteAuthentication remoteAuth;
  final NetworkInfo networkInfo;

  AccountRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.remoteStorage,
    required this.remoteAuth,
    required this.networkInfo,
  });

  @override
  Future<UserInformation> getUserInformation(String userId) async {
    try {
      if (userId == "guest") {
        final userInfoFromLocal = await localDataSource.getUser(userId);

        if (userInfoFromLocal == null) {
          throw EmptyDataException();
        }

        return userInfoFromLocal;
      }

      if (await networkInfo.isNotConnected) {
        final userInfoFromLocal = await localDataSource.getUser(userId);

        return userInfoFromLocal ?? remoteAuth.getCurrentUserAuthInfo();
      }

      final userInfoFromRemote = await remoteDataSource.getUser(userId);
      await localDataSource.addUser(userInfoFromRemote);

      return userInfoFromRemote;
    } on EmptyDataException {
      return remoteAuth.getCurrentUserAuthInfo();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserInformation> signInAnonymously() async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    try {
      await remoteAuth.signInAnonymously();

      final userInfo = UserInformationModel(
        id: "guest",
        firstName: "",
        lastName: "",
        email: "",
        phoneNumber: null,
        imageUrl: null,
        dateOfSignUp: DateTime.now(),
        userType: UserTypes.guest,
      );

      await localDataSource.addUser(userInfo);

      return userInfo;
    } catch (error) {
      rethrow;
    }
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
      UserInformation userInformation, String password) async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    try {
      final currentUser = await remoteAuth.signUpWithEmailAndPassword(
          userInformation.email, password);

      userInformation = userInformation.copyWith(
        id: currentUser.uid,
        dateOfSignUp: currentUser.metadata.creationTime,
      );

      remoteDataSource.addUser(userInformation.toModel());

      return userInformation;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<String?> sendUserImageAndType(File? image, UserTypes? userType) async {
    if (image == null && (userType == null || userType == UserTypes.normal)) {
      return null;
    }

    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      String? downloadUrl;

      if (image != null) {
        downloadUrl = await remoteStorage.upload(userId, image);
      }

      await remoteDataSource.storeUserImageAndType(
        userId,
        downloadUrl,
        (userType ?? UserTypes.normal).toStringValue(),
      );

      return downloadUrl;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserInformation> addOrUpdateUserData(
    UserInformation userInformation,
    File? image, {
    bool imageUpdated = true,
  }) async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      var downloadUrl = image == null ? null : userInformation.imageUrl;

      if (image != null && imageUpdated) {
        downloadUrl = await remoteStorage.upload(userId, image);
      }

      userInformation = userInformation.copyWithImageUrl(downloadUrl);

      await remoteDataSource.addUser(userInformation.toModel());

      await localDataSource.addUser(userInformation.toModel());

      return userInformation;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteEveryThingToCurrentUser() async {
    if (await networkInfo.isNotConnected) {
      throw OfflineException();
    }

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await remoteDataSource.deleteUserData(userId);

      await remoteStorage.delete(userId);

      await FirebaseAuth.instance.currentUser!.delete();
    } catch (error) {
      rethrow;
    }
  }
}
