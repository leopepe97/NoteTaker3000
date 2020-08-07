import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_taker_3000/model/note.dart';

class NotesModel extends ChangeNotifier {
  final _noteList = [
    Note(
      title: 'This is a title! :)',
      body:
          'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
      color: Colors.deepPurpleAccent,
    ),
    Note(
      title: 'This is a title! :)',
      body:
          'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
      color: Colors.deepPurpleAccent,
    ),
  ];

  final _archivedList = [
    Note(
      title: 'This is an archived title! :)',
      body:
          'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
      color: Colors.deepPurpleAccent,
      isArchived: true,
    ),
  ];

  UnmodifiableListView<Note> get noteList => UnmodifiableListView(_noteList);
  UnmodifiableListView<Note> get archivedList =>
      UnmodifiableListView(_archivedList);

  void addNote(Note newNote) {
    _noteList.add(newNote);
    notifyListeners();
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
}
