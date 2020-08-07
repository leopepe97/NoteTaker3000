import 'package:flutter/material.dart';

class Note {

  final int id;
  final String title;
  final String body;
  final Color color;
  bool isArchived;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'color': color.value,
      'isArchived': isArchived ? 1 : 0,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      color: Color(map['color']),
      isArchived: map['isArchived'] == 0 ? false : true,
    );
  }

  Note({this.id, this.title, this.body, this.color, this.isArchived = false});

}