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
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();
  final _random = new Random();

  @override
  void initState() {
    super.initState();
    Function() updateFirstNotes;
    updateFirstNotes = () {
      var notesModel = Provider.of<NotesModel>(context, listen: false);
      for (int i = 0; i < notesModel.noteList.length; i++) {
        _animatedListKey.currentState.insertItem(i);
      }
      notesModel.removeListener(updateFirstNotes);
    };
    Provider.of<NotesModel>(context, listen: false).addListener(updateFirstNotes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColors.grayPrimaryColor,
        child: Consumer<NotesModel>(
          builder: (context, notesModel, child) {
            return AnimatedList(
              key: _animatedListKey,
              initialItemCount: notesModel.noteList.length,
              itemBuilder: (context, index, animation) {
                final currentNote = notesModel.noteList.elementAt(index);
                return _buildNewNoteWidget(
                  currentNote,
                  animation,
                  onArchivePressed: () {
                    notesModel.archiveNote(index);
                    _animateNoteArchived(currentNote, index);
                  },
                  onDeletePressed: () {
                    notesModel.deleteNote(index);
                    _animateNoteDeleted(currentNote, index);
                  },
                );
              },
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
          //var notesModel = Provider.of<NotesModel>(context, listen: false);
          setState(() {
            //TODO: Add new note
          });
         // _animatedListKey.currentState
         //     .insertItem(notesModel.noteList.length - 1);
        },
      ),
    );
  }

  Widget _buildNewNoteWidget(Note note, Animation animation,
      {Function() onDeletePressed, Function() onArchivePressed}) {
    return SizeTransition(
      sizeFactor: animation,
      child: NoteWidget(
        note: note,
        onArchivePressed: onArchivePressed,
        onDeletePressed: onDeletePressed,
      ),
    );
  }

  Widget _buildDeletedNoteWidget(Note note, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: NoteWidget(
        note: note,
        onArchivePressed: () => {},
        onDeletePressed: () => {},
      ),
    );
  }

  Widget _buildArchivedNoteWidget(Note note, Animation animation) {
    return ScaleTransition(
      scale: animation,
      child: NoteWidget(
        note: note,
        onArchivePressed: () => {},
        onDeletePressed: () => {},
      ),
    );
  }

  void _animateNoteDeleted(Note note, int index) {
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildDeletedNoteWidget(note, animation);
    };
    _animatedListKey.currentState.removeItem(index, builder);
  }

  void _animateNoteArchived(Note note, int index) {
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildArchivedNoteWidget(note, animation);
    };
    _animatedListKey.currentState.removeItem(index, builder);
  }
}
