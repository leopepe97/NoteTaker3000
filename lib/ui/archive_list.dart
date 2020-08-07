import 'package:flutter/material.dart';
import 'package:note_taker_3000/model/notes_model.dart';
import 'package:provider/provider.dart';

import 'note_widget.dart';

class ArchiveList extends StatefulWidget {
  @override
  _ArchiveListState createState() => _ArchiveListState();
}

class _ArchiveListState extends State<ArchiveList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Consumer<NotesModel>(
          builder: (context, notesModel, child) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return NoteWidget(
                  note: notesModel.archivedList.elementAt(index),
                  onDeletePressed: () => notesModel.deleteArchivedNote(index),
                );
              },
              itemCount: notesModel.archivedList.length,
            );
          },
        ),
      ),
    );
  }
}
