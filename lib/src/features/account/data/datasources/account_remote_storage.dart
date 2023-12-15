import 'dart:io';
import '../../../../core/error/exceptions_without_message.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AccountRemoteStorage {
  Future<String> upload(String fileName, File file);
  Future<void> delete(String fileName);
}

const folderName = 'users';

class AccountFirebaseStorageImpl implements AccountRemoteStorage {
  @override
  Future<String> upload(String fileName, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('$folderName/$fileName');

      await ref.putFile(file);

      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<void> delete(String fileName) async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('$folderName/$fileName')
          .delete();
    } on FirebaseException catch (error) {
      if (error.code == "object-not-found") {
        return;
      }

      throw ServerException();
    } catch (error) {
      throw ServerException();
    }
  }
}
