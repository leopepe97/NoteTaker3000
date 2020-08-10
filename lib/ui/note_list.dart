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
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();
  final _random = new Random();
  var _isComposing = false;

  @override
  void initState() {
    super.initState();
    Function() updateFirstNotes;
    updateFirstNotes = () {
      final notesModel = Provider.of<NotesModel>(context, listen: false);
      for (int i = 0; i < notesModel.noteList.length; i++) {
        _animatedListKey.currentState.insertItem(i);
      }
      notesModel.removeListener(updateFirstNotes);
      notesModel.firstRun = false;
    };
    final notesModel = Provider.of<NotesModel>(context, listen: false);
    if (notesModel.firstRun)
      notesModel.addListener(updateFirstNotes);
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
          showBottomSheet(
            context: context,
            builder: (_) => _buildBottomSheet(),
          );
        },
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      color: CustomColors.grayPrimaryColor,
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      height: 250,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.grey[300],
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Title',
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _bodyController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Body',
                    ),
                  ),
                ),
                MaterialButton(
                  color: CustomColors.grayPrimaryColor,
                  onPressed: () => {
                    addNote(
                      _titleController.text,
                      _bodyController.text,
                    ),
                    _titleController.clear(),
                    _bodyController.clear(),
                    Navigator.pop(context)
                  },
                  child: const Text(
                    'Add!',
                    style: TextStyle(color: Colors.white),
                  ),
                  height: 40,
                )
              ],
            ),
          ),
        ],
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

  void addNote(String noteTitle, String noteBody) async {
    final notesModel = Provider.of<NotesModel>(context, listen: false);
    await notesModel.addNote(
      noteTitle,
      noteBody,
      CustomColors.noteColors[_random.nextInt(CustomColors.noteColors.length)]
    );
    _animatedListKey.currentState.insertItem(notesModel.noteList.length - 1);
  }
}
