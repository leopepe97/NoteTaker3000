import 'package:flutter/material.dart';

class Note {

  final String title;
  final String body;
  final Color color;
  bool isArchived;

  Note({this.title, this.body, this.color, this.isArchived = false});

}