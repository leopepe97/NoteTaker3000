import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_taker_3000/constants/custom_colors.dart';
import 'package:note_taker_3000/model/note.dart';
import 'package:note_taker_3000/model/notes_model.dart';
import 'package:note_taker_3000/ui/note_widget.dart';
import 'package:provider/provider.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final _random = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColors.grayPrimaryColor,
        child: Consumer<NotesModel>(
          builder: (context, notesModel, child) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return NoteWidget(
                  note: notesModel.noteList.elementAt(index),
                  onArchivePressed: () => notesModel.archiveNote(index),
                  onDeletePressed: () => notesModel.deleteNote(index),
                );
              },
              itemCount: notesModel.noteList.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        onPressed: () {
          setState(() {
            Provider.of<NotesModel>(context, listen: false).addNote(
              Note(
                title: 'This is a new title! :)',
                body:
                    'This is the body of a test note that I am making, I hope it works as good as I expect it to work',
                color: CustomColors.noteColors[_random.nextInt(CustomColors.noteColors.length)],
              ),
            );
          });
        },
      ),
    );
  }
}
