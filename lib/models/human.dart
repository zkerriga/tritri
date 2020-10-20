import 'dart:collection';
import 'package:flutter/cupertino.dart';

class Human with ChangeNotifier {
  final int     id;
  final String  firstName;
  final String  lastName;
  final String  link;
  final List<String>  skillsList;
  final List<String>  hobbiesList;

  Human({
      @required this.id,
      @required this.firstName,
      @required this.lastName,
      @required this.link,
      @required this.skillsList,
      @required this.hobbiesList
  });

  getSkillsString() {
    return skillsList.join(', ');
  }
  getHobbiesString() {
    return hobbiesList.join(', ');
  }
}

class HumansDataProvider with ChangeNotifier {
  List<Human> _items = [
    Human(id: 0, firstName: 'Bob', lastName: 'Dillan', link: 't.me/bob', skillsList: ['design', 'art'], hobbiesList: ['cook']),
    Human(id: 1, firstName: 'Dan', lastName: 'El', link: 't.me/zkerriga', skillsList: ['design', 'programming'], hobbiesList: ['music', 'urban']),
  ];

  bool  addHuman(Human human) {
    _items.add(human);
    notifyListeners();
    return true;
  }
  UnmodifiableListView<Human> get items => UnmodifiableListView(_items);

  // getHumanById(int id) => _items.firstWhere((human) => human.id == id);
}