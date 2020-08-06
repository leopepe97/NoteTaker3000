import 'package:flutter/material.dart';
import 'package:note_taker_3000/model/note.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    Key key,
    @required this.note,
    @required this.onDeletePressed,
    @required this.onArchivePressed,
  }) : super(key: key);

  final Note note;
  final Function() onDeletePressed;
  final Function() onArchivePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: note.color,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: buildNoteBody(context),
        ),
      ),
    );
  }

  Widget buildNoteBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          note.title,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(note.body),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white70,
              ),
              onPressed: onDeletePressed,
            ),
            if (onArchivePressed != null)
              IconButton(
                icon: const Icon(
                  Icons.archive,
                  color: Colors.white70,
                ),
                onPressed: onArchivePressed,
              ),
          ],
        )
      ],
    );
  }
}
