import 'package:flutter/material.dart';
import 'package:note_taker_3000/ui/note.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return noteList.elementAt(index);
          },
          itemCount: noteList.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        onPressed: () => setState(() {
          noteList.add(
            Note(
              title: 'This is a new title! :)',
              body: 'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
              color: Colors.deepPurpleAccent,
              onDeletePressed: () => {},
              onArchivePressed: null,
            )
          );
        })
      ),
    );
  }

  final noteList = [
    Note(
      title: 'This is a title! :)',
      body: 'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
      color: Colors.deepPurpleAccent,
      onDeletePressed: () => {},
      onArchivePressed: () => {},
    ),
    Note(
      title: 'This is a title! :)',
      body: 'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
      color: Colors.deepPurpleAccent,
      onDeletePressed: () => {},
      onArchivePressed: () => {},
    ),
    Note(
      title: 'This is a title! :)',
      body: 'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
      color: Colors.deepPurpleAccent,
      onDeletePressed: () => {},
      onArchivePressed: () => {},
    ),
    Note(
      title: 'This is a title! :)',
      body: 'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
      color: Colors.deepPurpleAccent,
      onDeletePressed: () => {},
      onArchivePressed: () => {},
    ),
    Note(
      title: 'This is a title! :)',
      body: 'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
      color: Colors.deepPurpleAccent,
      onDeletePressed: () => {},
      onArchivePressed: () => {},
    ),
    Note(
      title: 'This is a title! :)',
      body: 'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
      color: Colors.deepPurpleAccent,
      onDeletePressed: () => {},
      onArchivePressed: () => {},
    ),
  ];
}
