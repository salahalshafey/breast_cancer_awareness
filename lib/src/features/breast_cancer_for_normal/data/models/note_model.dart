import '../../domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    required super.id,
    required super.finding,
    required super.text,
    required super.recorderFilePath,
    required super.imageFilePath,
    required super.dateOfNote,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json["id"],
      finding: Note.findingFromString(json["finding"]),
      text: json["text"],
      recorderFilePath: json["recorder_file_path"],
      imageFilePath: json["image_file_path"],
      dateOfNote: DateTime.parse(json["date_of_note"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "finding": finding.toStringValue(),
        "text": text,
        "recorder_file_path": recorderFilePath,
        "image_file_path": imageFilePath,
        "date_of_note": dateOfNote.toString(),
      };
}
