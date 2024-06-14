import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  bool _isDarkMode = true;

  List<Note> get notes => _notes;
  bool get isDarkMode => _isDarkMode;

  NoteProvider() {
    loadNotes();
  }

  void addNote(Note note) {
    _notes.add(note);
    saveNotes();
    notifyListeners();
  }

  void updateNoteAt(int index, Note note) {
    _notes[index] = note;
    saveNotes();
    notifyListeners();
  }

  void removeNoteAt(int index) {
    _notes.removeAt(index);
    saveNotes();
    notifyListeners();
  }

  void loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesString = prefs.getString('notes');
    if (notesString != null) {
      final List<dynamic> notesJson = json.decode(notesString);
      _notes = notesJson.map((json) => Note.fromJson(json)).toList();
    }
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    notifyListeners();
  }

  void saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String notesString = json.encode(_notes.map((note) => note.toJson()).toList());
    prefs.setString('notes', notesString);
  }

  void toggleMode() {
    _isDarkMode = !_isDarkMode;
    saveMode();
    notifyListeners();
  }

  void saveMode() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }
}
