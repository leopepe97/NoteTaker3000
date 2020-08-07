import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notes_database.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, body TEXT, color INTEGER, isArchived INTEGER)",
        );
        db.insert('notes', {'id': 1, 'title': 'hola', 'body': 'cuerpa', 'color': 0xFFFFFFFF, 'isArchived': 0}, conflictAlgorithm: ConflictAlgorithm.replace);
        db.insert('notes', {'id': 2, 'title': 'hola2', 'body': 'cuerpa2', 'color': 0xFFFFFFFF, 'isArchived': 0}, conflictAlgorithm: ConflictAlgorithm.replace);
        db.insert('notes', {'id': 3, 'title': 'hola3', 'body': 'cuerpa3', 'color': 0xFFFFFFFF, 'isArchived': 1}, conflictAlgorithm: ConflictAlgorithm.replace);
      },
      version: 1,
    );
  }
}