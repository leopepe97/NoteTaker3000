import 'package:flutter/material.dart';
import 'package:note_taker_3000/model/notes_model.dart';
import 'package:note_taker_3000/ui/archive_list.dart';
import 'package:note_taker_3000/ui/note_list.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  static final _tabViewList = [
    NoteList(),
    ArchiveList(),
  ];

  static final _tabIconList = [
    Tab(icon: Icon(Icons.note)),
    Tab(icon: Icon(Icons.archive)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabViewList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Note Taker 3000'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: _tabIconList,
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => NotesModel(),
          child: TabBarView(
            children: _tabViewList,
          ),
        ),
      ),
    );
  }
}
