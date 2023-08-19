import '../repositories/notes_repositories.dart';

class DeleteAllNotesUsecase {
  final NotesRepository repository;

  const DeleteAllNotesUsecase(this.repository);

  Future<void> call(String userId) => repository.deleteAllNotes(userId);
}
