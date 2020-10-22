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
  Future<void> delete(int id) async {
    await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
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
  void deleteHuman(int id) {
    if (dbHelper.db != null) {
      _items.removeWhere((item) => item.id == id);
      notifyListeners();
      dbHelper.delete(id);
    }
  }
  void deleteAll(int checkcode) {
    if (dbHelper.db != null) {
      if (checkcode == 44213) {
        _items.removeWhere((item) {
            dbHelper.delete(item.id);
            return true;
          }
        );
        notifyListeners();
      }
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
