// ignore_for_file: use_build_context_synchronously

import '../../../../../../l10n/app_localizations.dart';
import '../../../../app.dart';
import '../../../../core/error/error_exceptions_with_message.dart';
import '../../../../core/error/exceptions_without_message.dart';
import '../../../../dispose_container.dart';

import '../../domain/entities/note.dart';
import '../../domain/usecases/add_note.dart';
import '../../domain/usecases/delete_all_notes.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/gt_all_notes.dart';

class Notes extends DisposableProvider {
  final GetAllNotesUsecase getAllNotesUsecase;
  final AddNoteUsecase addNoteUsecase;
  final DeleteNoteUsecase deleteNoteUsecase;
  final DeleteAllNotesUsecase deleteAllNotesUsecase;

  Notes({
    required this.getAllNotesUsecase,
    required this.addNoteUsecase,
    required this.deleteNoteUsecase,
    required this.deleteAllNotesUsecase,
  });

  final _context = navigatorKey.currentContext!;

  List<Note> _notes = [];

  Future<void> fetchAllNotes(String userId) async {
    try {
      _notes = await getAllNotesUsecase.call(userId);

      // _notes.sort((n1, n2) => n2.dateOfNote.compareTo(n1.dateOfNote));
      _notes = _notes.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw ErrorForDialog(
        AppLocalizations.of(_context)!.unexpectedErrorHappened,
      );
    }
  }

  List<Note> getAllNotes() {
    return [..._notes];
  }

  Note getNote(String noteId) {
    return _notes.firstWhere((note) => note.id == noteId);
  }

  Future<void> addNote(String userId, Note note) async {
    try {
      await addNoteUsecase.call(userId, note);
    } on LocalStorageException {
      throw ErrorForDialog(
        AppLocalizations.of(_context)!.notAbleToSaveFilesToLocalDeviceStorage,
      );
    } catch (error) {
      throw ErrorForDialog(
        AppLocalizations.of(_context)!.unexpectedErrorHappened,
      );
    }
  }

  Future<void> deleteNote(String userId, String noteId) async {
    try {
      await deleteNoteUsecase.call(userId, noteId);

      _notes.removeWhere((note) => note.id == noteId);
      notifyListeners();
    } on LocalStorageException {
      throw ErrorForDialog(
        AppLocalizations.of(_context)!
            .notAbleToDeleteFilesFromLocalDeviceStorage,
      );
    } catch (error) {
      throw ErrorForDialog(
        AppLocalizations.of(_context)!.unexpectedErrorHappened,
      );
    }
  }

  Future<void> deleteAllNotes(String userId) async {
    try {
      await deleteAllNotesUsecase.call(userId);

      _notes = [];
      notifyListeners();
    } on LocalStorageException {
      throw ErrorForDialog(
        AppLocalizations.of(_context)!
            .notAbleToDeleteFilesFromLocalDeviceStorage,
      );
    } catch (error) {
      throw ErrorForDialog(
        AppLocalizations.of(_context)!.unexpectedErrorHappened,
      );
    }
  }

  @override
  void disposeValues() {
    _notes = [];
  }
}
