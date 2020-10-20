import 'dart:async';
import 'dart:io' as io;

import 'package:tritri/models/human.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  static const String _tableName = "Humans";

  Future<Database> get db async {
    if (_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$_tableName.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, link TEXT, skillsList TEXT, hobbiesList TEXT)"
    );
  }

  Future<int> saveHuman(Human human) async {
    var dbClient = await db;
    int res = await dbClient.insert(_tableName, human.toMap());
    return res;
  }

  Future<List<Human>> getAllHumans() async {
    const String sql = "SELECT * FROM $_tableName";
    var dbClient = await db;

    return (await dbClient.rawQuery(sql))
        .map((humanMap) => Human.map(humanMap));
  }

  Future<int> deleteHuman(Human human) async {
    const String sql = "DELETE FROM $_tableName WHERE id = ?";
    var dbClient = await db;

    int res = await dbClient.rawDelete(sql, [human.id]);
    return res;
  }

  Future<bool> update(Human human) async {
    var dbClient = await db;
    int res = await dbClient.update(
        _tableName,
        human.toMap(),
        where: "id = ?",
        whereArgs: <int>[human.id]
    );
    return res > 0 ? true : false;
  }
}

/*
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper with ChangeNotifier {
  static final tableName = 'my_table';
  sql.Database db;

  DBHelper() {
    // this will run when provider is instantiate the first time
    init();
  }

  void init() async {
    final dbPath = await sql.getDatabasesPath();
    db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        final stmt = '''CREATE TABLE IF NOT EXISTS $tableName (
            id TEXT PRIMARY KEY,
            title TEXT,
            image TEXT
        )'''.trim().replaceAll(RegExp(r'[\s]{2,}'), ' ');
        return db.execute(stmt);
      },
      version: 1,
    );
    // the init funciton is async so it won't block the main thread
    // notify provider that depends on it when done
    notifyListeners();
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    return await db.query(table);
  }
}
 */