import '../../data/models/note_model.dart';

class Note {
  final String id;
  final Findings finding;
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
    Findings? finding,
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

  static Findings findingFromString(String finding) {
    switch (finding) {
      case "All is well":
        return Findings.allIsWell;

      case "Not sure":
        return Findings.notSure;

      case "Noticed something":
        return Findings.noticedSomething;

      default:
        return Findings.allIsWell;
    }
  }

  @override
  String toString() {
    return "Note($id, ${finding.toStringValue()}, $text, $recorderFilePath, $imageFilePath, $dateOfNote)";
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

enum Findings {
  allIsWell,
  notSure,
  noticedSomething,
}

extension FindingsExtension on Findings {
  String toStringValue() {
    switch (this) {
      case Findings.allIsWell:
        return "All is well";
      case Findings.notSure:
        return "Not sure";
      case Findings.noticedSomething:
        return "Noticed something";
    }
  }
}
