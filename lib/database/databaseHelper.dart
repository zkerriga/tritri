import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tritri/models/human.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper with ChangeNotifier {
  static const String _tableName = "Humans";
  Database db;

  DBHelper() {
    initDB();
  }
  initDB() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, "$_tableName.db");
    db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          return await db.execute(
              "CREATE TABLE $_tableName ("
                  "id INTEGER PRIMARY KEY,"
                  "firstName TEXT,"
                  "lastName TEXT,"
                  "link TEXT,"
                  "skillsList TEXT,"
                  "hobbiesList TEXT"
                  ")"
          );
        },
    );
    print("[+] INIT DB");
    notifyListeners();
  }
  Future<void> insert(Map<String, dynamic> data) async {
    await db.insert(_tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Map<String, dynamic>>> getData() async {
    return await db.query(_tableName);
  }
}

class DataProvider with ChangeNotifier {
  final DBHelper dbHelper;
  List<Human> _items = [];

  DataProvider(this._items, {this.dbHelper}) {
    if (dbHelper != null)
      fetchAndSetData();
  }

  List<Human> get items => [..._items];

  void addHuman(Human newHuman) {
    if (dbHelper.db != null) { // do not execute if db is not instantiate
      newHuman.setHumanId(DateTime.now().millisecondsSinceEpoch);
      _items.add(newHuman);
      notifyListeners();
      dbHelper.insert(newHuman.toMap());
    }
  }
  Future<void> fetchAndSetData() async {
    if (dbHelper.db != null) { // do not execute if db is not instantiate
      final dataList = await dbHelper.getData();
      _items = dataList.isNotEmpty
          ? dataList
            .map((humanMap) => Human.map(humanMap))
            .toList()
          : [];
      notifyListeners();
    }
  }
}

/*
class DBProvider with ChangeNotifier {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static const String _tableName = "Humans";

  Database _database;

  Future<Database> get database async {
    if (_database == null)
      _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$_tableName.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE $_tableName ("
                  "id INTEGER PRIMARY KEY,"
                  "firstName TEXT,"
                  "lastName TEXT,"
                  "link TEXT,"
                  "skillsList TEXT,"
                  "hobbiesList TEXT"
                  ")"
          );
        });
  }
  Future<int> newHuman(Human newHuman) async {
    const String sql = "SELECT MAX(id)+1 as id FROM $_tableName";
    final dbClient = await database;

    newHuman.setHumanId((await dbClient.rawQuery(sql)).first["id"]);
    return (
        await dbClient.insert(_tableName, newHuman.toMap())
    );
  }
  Future<int> updateHuman(Human human) async {
    final dbClient = await database;

    return (
        await dbClient.update(
          _tableName,
          human.toMap(),
          where: "id = ?",
          whereArgs: <int>[human.id]
        )
    );
  }
  getClient(int id) async {
    final dbClient = await database;
    final res = await dbClient.query(_tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty
        ? Human.map(res.first)
        : null;
  }
  Future<List<Human>> getAllClients() async {
    final dbClient = await database;
    const String sql = "SELECT * FROM $_tableName";
    final res = await dbClient.rawQuery(sql);

    return (res.isNotEmpty
        ? res.map((humanMap) => Human.map(humanMap)).toList()
        : []
    );
  }
  deleteHuman(int id) async {
    final dbClient = await database;
    return dbClient.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
  deleteAll() async {
    final dbClient = await database;
    dbClient.rawDelete("Delete * from $_tableName");
  }
}
 */
/*
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
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
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

  /*Future<List<Human>> getAllHumans() async {
    const String sql = "SELECT * FROM $_tableName";
    var dbClient = await db;

    return (await dbClient.rawQuery(sql))
        .map((humanMap) => Human.map(humanMap));
  }*/

  getAllHumans() async {
    const String sql = "SELECT * FROM $_tableName";
    final dbClient = await db;

    final res = await dbClient.rawQuery(sql);
    List<Human> list = res.isNotEmpty ? res.map((humanMap) => Human.map(humanMap)).toList() : [];
    return list;
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
*/
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