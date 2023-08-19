import '../../data/models/note_model.dart';

class Note {
  final String id;
  final String finding;
  final String? text;
  final String? recorderFilePath;
  final String? imageFilePath;
  final DateTime dateOfNote;

  const Note({
    required this.id,
    required this.finding,
    required this.text,
    required this.recorderFilePath,
    required this.imageFilePath,
    required this.dateOfNote,
  });

  Note copyWith({
    String? id,
    String? finding,
    String? text,
    String? recorderFilePath,
    String? imageFilePath,
    DateTime? dateOfNote,
  }) {
    return Note(
      id: id ?? this.id,
      finding: finding ?? this.finding,
      text: text ?? this.text,
      recorderFilePath: recorderFilePath ?? this.recorderFilePath,
      imageFilePath: imageFilePath ?? this.imageFilePath,
      dateOfNote: dateOfNote ?? this.dateOfNote,
    );
  }

  NoteModel toModel() {
    return NoteModel(
      id: id,
      finding: finding,
      text: text,
      recorderFilePath: recorderFilePath,
      imageFilePath: imageFilePath,
      dateOfNote: dateOfNote,
    );
  }

  @override
  String toString() {
    return "Note($id, $finding, $text, $recorderFilePath, $imageFilePath, $dateOfNote)";
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is Note) {
      return id == other.id;
    }
    return false;
  }
}
