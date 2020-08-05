import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Note extends StatelessWidget {
  const Note({
    Key key,
    @required this.title,
    @required this.body,
    @required this.color,
    @required this.onDeletePressed,
    @required this.onArchivePressed,
  }) : super(key: key);

  final String title;
  final String body;
  final Color color;
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
        color: color,
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
          title,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(body),
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
