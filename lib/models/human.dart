import 'dart:collection';
import 'package:flutter/material.dart';

class Human with ChangeNotifier {
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
  String get link => _link;
  UnmodifiableListView<String> get skills => UnmodifiableListView(_skillsList);
  UnmodifiableListView<String> get hobbies => UnmodifiableListView(_hobbiesList);

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
    ..["firstName"] = _firstName
    ..["lastName"] = _lastName
    ..["link"] = _link
    ..["skillsList"] = getSkillsString()
    ..["hobbiesList"] = getHobbiesString();
  }
}
