import '../entities/note.dart';
import '../repositories/notes_repositories.dart';

class AddNoteUsecase {
  final NotesRepository repository;

  const AddNoteUsecase(this.repository);

  Future<void> call(String userId, Note note) =>
      repository.addNote(userId, note);
}
