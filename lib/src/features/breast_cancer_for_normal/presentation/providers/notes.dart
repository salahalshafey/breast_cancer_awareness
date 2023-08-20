import '../../../../dispose_container.dart';

import '../../../../core/error/exceptions.dart';

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

  List<Note> _notes = [];

  Future<void> fetchAllNotes(String userId) async {
    try {
      _notes = await getAllNotesUsecase.call(userId);

      // _notes.sort((n1, n2) => n2.dateOfNote.compareTo(n1.dateOfNote));
      _notes = _notes.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw Error('An unexpected error happened.');
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
      throw Error("Not able to save files to local device storage.");
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<void> deleteNote(String userId, String noteId) async {
    try {
      await deleteNoteUsecase.call(userId, noteId);

      _notes.removeWhere((note) => note.id == noteId);
      notifyListeners();
    } on LocalStorageException {
      throw Error("Not able to delete files from local device storage.");
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  Future<void> deleteAllNotes(String userId) async {
    try {
      await deleteAllNotesUsecase.call(userId);

      _notes = [];
      notifyListeners();
    } on LocalStorageException {
      throw Error("Not able to delete files from local device storage.");
    } catch (error) {
      throw Error('An unexpected error happened.');
    }
  }

  @override
  void disposeValues() {
    _notes = [];
  }
}
