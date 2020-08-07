import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_taker_3000/db/db.dart';
import 'package:note_taker_3000/model/note.dart';
import 'package:sqflite/sqflite.dart';

class NotesModel extends ChangeNotifier {
  final _noteList = <Note>[];
  final _archivedList = <Note>[];

  var firstRun = true;

  UnmodifiableListView<Note> get noteList => UnmodifiableListView(_noteList);
  UnmodifiableListView<Note> get archivedList =>
      UnmodifiableListView(_archivedList);

  NotesModel() {
    _fetchAllNotes();
  }

  void deleteNote(int index) {
    _noteList.removeAt(index);
    notifyListeners();
  }

  void deleteArchivedNote(int index) {
    _archivedList.removeAt(index);
    notifyListeners();
  }

  void archiveNote(int index) {
    _noteList.elementAt(index).isArchived = true;
    _archivedList.add(_noteList.elementAt(index));
    _noteList.removeAt(index);
    notifyListeners();
  }

  void _fetchAllNotes() async {
    final Database db = await DatabaseService.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('notes');
    maps.forEach((map) {
      var note = Note.fromMap(map);
      if (note.isArchived)
        _archivedList.add(note);
      else
        _noteList.add(note);
    });
    notifyListeners();
  }
  
  Future<void> addNote(String title, String body, Color color) async {
    final Database db = await DatabaseService.getDatabase();
    final newNote = Note(
      id: -1,
      title: title,
      body: body,
      color: color,
      isArchived: false,
    );
    final newId = await db.insert(
      'notes',
      newNote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    newNote.id = newId;
    _noteList.add(newNote);
    notifyListeners();
  }
}
