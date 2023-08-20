import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

import '../models/note_model.dart';

abstract class NotesLocalDataSource {
  Future<List<NoteModel>> getAllNotes(String userId);

  Future<void> addNote(String userId, NoteModel note);

  Future<NoteModel> deleteNote(String userId, String noteId);

  Future<List<NoteModel>> deleteAllNotes(String userId);
}

class NotesSharedPreferencesImpl implements NotesLocalDataSource {
  String _key(String userId) => "${userId}_notes";

  @override
  Future<List<NoteModel>> getAllNotes(String userId) async {
    final prefs = await SharedPreferences.getInstance();

    final allNotesJson = prefs.getString(_key(userId));

    if (allNotesJson == null) {
      return [];
    }

    final List<dynamic> allNotes = jsonDecode(allNotesJson);

    return allNotes.map((noteJson) => NoteModel.fromJson(noteJson)).toList();
  }

  @override
  Future<void> addNote(String userId, NoteModel note) async {
    final prefs = await SharedPreferences.getInstance();

    final allNotesJson = prefs.getString(_key(userId));

    if (allNotesJson == null) {
      prefs.setString(_key(userId), jsonEncode([note.toJson()]));
    } else {
      final List<dynamic> allNotes = jsonDecode(allNotesJson);
      allNotes.add(note.toJson());

      await prefs.setString(_key(userId), jsonEncode(allNotes));
    }
  }

  @override
  Future<NoteModel> deleteNote(String userId, String noteId) async {
    final prefs = await SharedPreferences.getInstance();

    final allNotesJson = prefs.getString(_key(userId));

    if (allNotesJson == null) {
      throw EmptyDataException();
    } else {
      final List<dynamic> allNotes = jsonDecode(allNotesJson);
      final removedNote = allNotes.firstWhere((note) => note["id"] == noteId);

      allNotes.removeWhere((note) {
        return note["id"] == noteId;
      });

      await prefs.setString(_key(userId), jsonEncode(allNotes));

      return NoteModel.fromJson(removedNote);
    }
  }

  @override
  Future<List<NoteModel>> deleteAllNotes(String userId) async {
    final prefs = await SharedPreferences.getInstance();

    final allNotesJson = prefs.getString(_key(userId));

    if (allNotesJson == null) {
      return [];
    }

    final List<dynamic> allNotes = jsonDecode(allNotesJson);

    await prefs.remove(_key(userId));

    return allNotes.map((noteJson) => NoteModel.fromJson(noteJson)).toList();
  }
}
