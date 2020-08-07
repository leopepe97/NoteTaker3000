import 'package:flutter/material.dart';
import 'package:note_taker_3000/constants/custom_colors.dart';
import 'package:note_taker_3000/model/note.dart';
import 'package:note_taker_3000/model/notes_model.dart';
import 'package:provider/provider.dart';

import 'note_widget.dart';

class ArchiveList extends StatefulWidget {
  @override
  _ArchiveListState createState() => _ArchiveListState();
}

class _ArchiveListState extends State<ArchiveList> {
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColors.grayPrimaryColor,
        child: Consumer<NotesModel>(
          builder: (context, notesModel, child) {
            return AnimatedList(
              key: _animatedListKey,
              initialItemCount: notesModel.archivedList.length,
              itemBuilder: (context, index, animation) {
                final currentNote = notesModel.archivedList.elementAt(index);
                return _buildNewNoteWidget(
                  currentNote,
                  animation,
                  onDeletePressed: () {
                    notesModel.deleteArchivedNote(index);
                    _animateNoteDeleted(currentNote, index);
                  },
                );
              },
            );
          },
        ),
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
}
