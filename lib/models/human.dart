import 'dart:collection';
// import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tritri/database/databaseHelper.dart';
// import 'package:tritri/widgets/itemHuman.dart';

class Human {
  int           id;
  String        _firstName;
  String        _lastName;
  String        _link;
  List<String>  _skillsList;
  List<String>  _hobbiesList;
  static const String separator = ", ";

  Human(
      this._firstName,
      this._lastName,
      this._link,
      this._skillsList,
      this._hobbiesList,
      );

  Human.map(Map humanMap) {
    this.id           = humanMap["id"];
    this._firstName   = humanMap["firstName"];
    this._lastName    = humanMap["lastName"];
    this._link        = humanMap["link"];
    this._skillsList  = humanMap["skillsList"].split(Human.separator);
    this._hobbiesList = humanMap["lastName"].split(Human.separator);
  }

  String get firstName => _firstName;
  String get lastName => _lastName;
  // List<String> get skills => _skillsList;
  // List<String> get hobbies => _hobbiesList;

  setHumanId(int id) {
    this.id = id;
  }
  getSkillsString() {
    return _skillsList?.join(separator);
  }
  getHobbiesString() {
    return _hobbiesList?.join(separator);
  }
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>()
    ..["id"] = id
    ..["firstname"] = _firstName
    ..["lastname"] = _lastName
    ..["link"] = _link
    ..["skillsList"] = getSkillsString()
    ..["hobbiesList"] = getHobbiesString();
  }
}

/*
class HumansDataProvider with ChangeNotifier {
  final _db = DatabaseHelper();
  // var _db = DatabaseHelper();
  // List<Human> _items;

  // HumansDataProvider() {
  //   _itemsInit();
  // }

  // _itemsInit() async {
  //   _items = await _db.getAllHumans();
  //   print("Check!");
  // }
  List<Human> _items = [
    Human('Bob', 'Dillan', 't.me/bob', ['design', 'art'], ['cook']),
    Human('Dan', 'El', 't.me/zkerriga', ['design', 'programming'], ['music', 'urban']),

    // Human(firstName: 'Bob', lastName: 'Dillan', link: 't.me/bob', skillsList: ['design', 'art'], hobbiesList: ['cook']),
    // Human(firstName: 'Dan', lastName: 'El', link: 't.me/zkerriga', skillsList: ['design', 'programming'], hobbiesList: ['music', 'urban']),
  ];

  addFackenHuman() {
    addHuman(Human("Test", "${DateTime.now()}", "t.me/test", ["test1", "test2", "test3"], ["kek1", "kek2"]));
  }
  bool  addHuman(Human human) {
    _items.add(human);
    notifyListeners();
    // _db.saveHuman(human);
    return true;
  }
  UnmodifiableListView<Human> get items => UnmodifiableListView(_items);

  // UnmodifiableListView<Human> get items {
  //   FutureBuilder<List<Human>>(
  //       future: _db.getAllHumans(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return ItemHuman();
  //         }
  //         return CircularProgressIndicator();
  //       }
  //   );
  // }
  getHumanById(int id) => _items.firstWhere((human) => human.id == id);
}
*/