import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';

class DatabaseProvider {
  static final DatabaseProvider db = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, Constants.DBNAME);
    var myDb = openDatabase(path, version: Constants.DB_VERSION, onCreate: initDB);
    return myDb;
  }

  void initDB(Database db, int version) async {
    await db.execute("CREATE TABLE ${Constants.TABLE_NAME} ("
        "${Constants.COLUM_ID} TEXT NOT NULL UNIQUE , "
        "${Constants.COLUM_TITLE} TEXT, "
        "${Constants.COLUM_NOTE_CONTENT} TEXT, "
        "${Constants.COLUM_DATE} TEXT, "
        "${Constants.COLUM_IS_FLAGGED} INTEGER "
        ")");
  }
}
