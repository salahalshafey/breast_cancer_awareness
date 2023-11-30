import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../../../core/error/exceptions.dart';

abstract class NotesLocalStorage {
  Future<String> save(String tempFilePath, String newFilePath);

  Future<void> delete(String filePath);

  Future<void> deleteAllDir(String dirPath);
}

class NotesLocalStorageImpl implements NotesLocalStorage {
  @override
  Future<String> save(String tempFilePath, String newFilePath) async {
    try {
      final appDocumentsDir = await getApplicationDocumentsDirectory();

      final sourceFile = File(tempFilePath);
      final destinationFile = File("${appDocumentsDir.path}/$newFilePath");

      await destinationFile.create(recursive: true);
      await sourceFile.copy(destinationFile.path);

      return destinationFile.path;
    } catch (error) {
      throw LocalStorageException();
    }
  }

  @override
  Future<void> delete(String filePath) async {
    try {
      await File(filePath).delete();
    } catch (error) {
      throw LocalStorageException();
    }
  }

  @override
  Future<void> deleteAllDir(String dirPath) async {
    try {
      await File(dirPath).delete(recursive: true);
    } on PathNotFoundException {
      return;
    } catch (error) {
      throw LocalStorageException();
    }
  }
}
