import '../entities/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getAllNotes(String userId);

  Future<void> addNote(String userId, Note note);

  Future<void> deleteNote(String userId, String noteId);

  Future<void> deleteAllNotes(String userId);
}
