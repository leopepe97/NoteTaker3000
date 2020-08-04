import 'package:flutter/material.dart';
import 'package:note_taker_3000/constants/constants.dart';
import 'package:note_taker_3000/ui/archive_list.dart';
import 'package:note_taker_3000/ui/note_list.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  int _selectedIndex = Constants.NOTES_LIST;

  static final _tabList = [
    NoteList(),
    ArchiveList()
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == Constants.NOTES_LIST ? 'All Notes' : 'Archive'),
        centerTitle: true,
      ),
      body: _tabList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            title: Text('Notes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            title: Text('Archive'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onTabSelected,
      ),
    );
  }
}
