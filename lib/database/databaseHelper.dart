import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import 'package:tritri/models/human.dart';

class DBHelper with ChangeNotifier {
  static const String mainTableName = "Humans";
  static const String _databasePath = "Android/data/com.zkerriga.tritri/data";
  static const String _absoluteDatabasePath = "/storage/emulated/0/$_databasePath";
  static const String normalDatabasePath = "$_databasePath/$mainTableName.db";
  Database db;

  DBHelper() {
    initDB();
  }

  initPermissions() async {
    final status = await Permission.storage.status;
    if (status.isUndetermined) {
      if (await Permission.storage.request().isGranted) {
        print("[+] Permissions ok!");
      }
      else {
        openAppSettings();
      }
    }
    if (await Permission.speech.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
  }
  initDB() async {
    await initPermissions();
    final Directory documentsDirectory = Directory(_absoluteDatabasePath);
    documentsDirectory.create(recursive: true);
    final String path = join(documentsDirectory.absolute.path, "$mainTableName.db");
    db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          return await db.execute(
              "CREATE TABLE $mainTableName ("
                  "${Human.mapId} INTEGER PRIMARY KEY,"
                  "${Human.mapFirstName} TEXT,"
                  "${Human.mapLastName} TEXT,"
                  "${Human.mapLink} TEXT,"
                  "${Human.mapSkillsList} TEXT,"
                  "${Human.mapHobbiesList} TEXT"
                  ")"
          );
        },
    );
    // print("[+] $path");
    notifyListeners();
  }
  Future<void> insert(Map<String, dynamic> data) async {
    await db.insert(mainTableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> delete(int id) async {
    await db.delete(mainTableName, where: "${Human.mapId} = ?", whereArgs: [id]);
  }
  Future<List<Map<String, dynamic>>> getData() async {
    return await db.query(mainTableName);
  }
}

class DataProvider with ChangeNotifier {
  final DBHelper dbHelper;
  List<Human> _items = [];
  Set<String> _skillsSet = Set();
  Set<String> _hobbiesSet = Set();

  DataProvider(this._items, {this.dbHelper}) {
    if (dbHelper != null)
      fetchAndSetData();
  }

  int get skillsQuantity => _skillsSet.length;
  int get hobbiesQuantity => _hobbiesSet.length;
  List<Human> get items => [..._items];

  void addHuman(Human newHuman) {
    if (dbHelper.db != null) { // do not execute if db is not instantiate
      newHuman.setHumanId(DateTime.now().millisecondsSinceEpoch);
      _items.add(newHuman);
      _skillsSet.addAll(newHuman.skills);
      _hobbiesSet.addAll(newHuman.hobbies);
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
      _items.forEach((Human human) {
        _skillsSet.addAll(human.skills);
        _hobbiesSet.addAll(human.hobbies);
      });
    }
  }
}
