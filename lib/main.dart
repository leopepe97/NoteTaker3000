import 'package:flutter/material.dart';
import 'package:note_taker_3000/ui/home_route.dart';
import 'package:note_taker_3000/ui/note_list.dart';

void main() {
  runApp(NoteTaker3000());
}

class NoteTaker3000 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeRoute(),
    );
  }
}