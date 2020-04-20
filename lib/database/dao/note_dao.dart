import 'package:notesbloc/models/note.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';
import '../database.dart';

class NoteDao{
  final dbProvider = DatabaseProvider.db;

  Future<int> createNote(Note note) async {
    final dbClient = await dbProvider.database;
    return dbClient.insert(Constants.TABLE_NAME, note.toDatabaseJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Note>> getAllNotes({List<String> columns, String query}) async {
    final dbClient = await dbProvider.database;
    List<Map<String, dynamic>> result;
    if(query != null && query.isNotEmpty) {
        result = await dbClient.query(Constants.TABLE_NAME, columns: columns, where: 'description LIKE ?', whereArgs: ["%$query%"]);
    }else{
      result = await dbClient.query(Constants.TABLE_NAME, columns: columns);
    }

    List<Note> notes = result.isNotEmpty ? result.map((note) => Note.fromDatabaseJson(note)).toList() : [];
    return notes;
  }

  Future<int> deleteItem(String id) async {
    var dbClient = await dbProvider.database;
    return dbClient.delete(Constants.TABLE_NAME,
        where: "${Constants.COLUM_ID} = ?", whereArgs: [id]);
  }

  Future<int> updateItem(Note note) async {
    var dbClient = await dbProvider.database;
    return dbClient.update(Constants.TABLE_NAME, note.toDatabaseJson(),
        where: "${Constants.COLUM_ID} = ?", whereArgs: [note.id]);
  }
}