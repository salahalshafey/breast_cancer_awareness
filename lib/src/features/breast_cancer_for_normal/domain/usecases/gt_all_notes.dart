import '../entities/note.dart';
import '../repositories/notes_repositories.dart';

class GetAllNotesUsecase {
  final NotesRepository repository;

  const GetAllNotesUsecase(this.repository);

  Future<List<Note>> call(String userId) => repository.getAllNotes(userId);
}
