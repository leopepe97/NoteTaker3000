import 'package:flutter/material.dart';

class Note {

  final int id;
  final String title;
  final String body;
  final Color color;
  bool isArchived;

  Note({this.id, this.title, this.body, this.color, this.isArchived = false});

}