import '../repositories/notes_repositories.dart';

class DeleteNoteUsecase {
  final NotesRepository repository;

  const DeleteNoteUsecase(this.repository);

  Future<void> call(String userId, String noteId) =>
      repository.deleteNote(userId, noteId);
}
