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

  void deleteNote(int index) async {
    final deletedNote = _noteList.removeAt(index);
    notifyListeners();
    final Database db = await DatabaseService.getDatabase();
    db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [deletedNote.id],
    );
  }

  void deleteArchivedNote(int index) async {
    final deletedNote = _archivedList.removeAt(index);
    notifyListeners();
    final Database db = await DatabaseService.getDatabase();
    db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [deletedNote.id],
    );
  }

  void archiveNote(int index) async {
    _noteList.elementAt(index).isArchived = true;
    _archivedList.add(_noteList.elementAt(index));
    final updatedNote = _noteList.removeAt(index);
    notifyListeners();
    final Database db = await DatabaseService.getDatabase();
    db.update(
      'notes',
      updatedNote.toMap(),
      where: 'id = ?',
      whereArgs: [updatedNote.id],
    );
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
