import 'dart:collection';
import 'package:flutter/cupertino.dart';

class Human with ChangeNotifier {
  int           id;
  String        _firstName;
  String        _lastName;
  String        _link;
  List<String>  _skillsList;
  List<String>  _hobbiesList;
  static const String separator = ', ';

  Human(
      this._firstName,
      this._lastName,
      this._link,
      this._skillsList,
      this._hobbiesList
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
  List<String> get skills => _skillsList;
  List<String> get hobbies => _hobbiesList;

  setHumanId(int id) {
    this.id = id;
  }
  getSkillsString() {
    return _skillsList.join(separator);
  }
  getHobbiesString() {
    return _hobbiesList.join(separator);
  }
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>()
    ..["firstname"] = _firstName
    ..["lastname"] = _lastName
    ..["link"] = _link
    ..["skillsList"] = getSkillsString()
    ..["hobbiesList"] = getHobbiesString();
  }
}

class HumansDataProvider with ChangeNotifier {
  List<Human> _items = [
    Human('Bob', 'Dillan', 't.me/bob', ['design', 'art'], ['cook']),
    // Human(firstName: 'Bob', lastName: 'Dillan', link: 't.me/bob', skillsList: ['design', 'art'], hobbiesList: ['cook']),
    // Human(firstName: 'Dan', lastName: 'El', link: 't.me/zkerriga', skillsList: ['design', 'programming'], hobbiesList: ['music', 'urban']),
  ];

  bool  addHuman(Human human) {
    _items.add(human);
    notifyListeners();
    return true;
  }
  UnmodifiableListView<Human> get items => UnmodifiableListView(_items);

  // getHumanById(int id) => _items.firstWhere((human) => human.id == id);
}
