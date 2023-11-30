import 'package:path_provider/path_provider.dart';

import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repositories.dart';

import '../datasources/notes_local_data_source.dart';
import '../datasources/notes_local_storage.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource localDataSource;
  final NotesLocalStorage localStorage;

  NotesRepositoryImpl({
    required this.localDataSource,
    required this.localStorage,
  });

  @override
  Future<List<Note>> getAllNotes(String userId) {
    return localDataSource.getAllNotes(userId);
  }

  @override
  Future<void> addNote(String userId, Note note) async {
    try {
      String? newImagePath;
      String? newRecorderPath;

      if (note.imageFilePath != null) {
        newImagePath = await localStorage.save(
          note.imageFilePath!,
          _getFileNewPath(note, isImage: true),
        );
      }

      if (note.recorderFilePath != null) {
        newRecorderPath = await localStorage.save(
          note.recorderFilePath!,
          _getFileNewPath(note, isImage: false),
        );
      }

      note = note.copyWith(
        imageFilePath: newImagePath,
        recorderFilePath: newRecorderPath,
      );

      await localDataSource.addNote(userId, note.toModel());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteNote(String userId, String noteId) async {
    final deletedNote = await localDataSource.deleteNote(userId, noteId);

    if (deletedNote.imageFilePath != null) {
      await localStorage.delete(deletedNote.imageFilePath!);
    }

    if (deletedNote.recorderFilePath != null) {
      await localStorage.delete(deletedNote.recorderFilePath!);
    }
  }

  @override
  Future<void> deleteAllNotes(String userId) async {
    await localDataSource.deleteAllNotes(userId);

    final appDocumentsDir = await getApplicationDocumentsDirectory();

    final dirPath = "${appDocumentsDir.path}/notes";

    await localStorage.deleteAllDir(dirPath);
  }

  String _getFileNewPath(Note note, {required bool isImage}) {
    final folderName = isImage ? "notes/images" : "notes/sounds";

    final fileName = note.id;

    final fileExtension = isImage
        ? note.imageFilePath!.split(".").last
        : note.recorderFilePath!.split(".").last;

    return "$folderName/$fileName.$fileExtension";
  }
}
