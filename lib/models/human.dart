import 'dart:collection';
import 'package:flutter/material.dart';

class Human with ChangeNotifier {
  static const String mapId = "id";
  static const String mapFirstName = "firstName";
  static const String mapLastName = "lastName";
  static const String mapLink = "link";
  static const String mapSkillsList = "skillsList";
  static const String mapHobbiesList = "hobbiesList";

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
    this.id           = humanMap[mapId];
    this._firstName   = humanMap[mapFirstName];
    this._lastName    = humanMap[mapLastName];
    this._link        = humanMap[mapLink];
    this._skillsList  = humanMap[mapSkillsList].split(Human.separator);
    this._hobbiesList = humanMap[mapHobbiesList].split(Human.separator);
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
    ..[mapId] = id
    ..[mapFirstName] = _firstName
    ..[mapLastName] = _lastName
    ..[mapLink] = _link
    ..[mapSkillsList] = getSkillsString()
    ..[mapHobbiesList] = getHobbiesString();
  }
}
