import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/models/myColors.dart';

extension _StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
  List<String> toSkillsList() {
    const String _splitter = " ";
    return this
        .replaceAll(RegExp(r"^[ ,.]+"), "")
        .replaceAll(RegExp(r"[ ,.]+$"), "")
        .toLowerCase()
        .replaceAll(RegExp(r"[ ,.]+"), _splitter)
        .split(_splitter)
        .toSet()
        .toList();
  }
}

class CreateHumanPage extends StatelessWidget {
  const CreateHumanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Создание карточки'),
        backgroundColor: MyColors.lightBlue,
      ),
      backgroundColor: MyColors.white,
      resizeToAvoidBottomPadding: false,
      body: _CreateHumanForm(),
    );
  }
}

class _CreateHumanForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateHumanState();
}

class _CreateHumanState extends State {
  final _formKey = GlobalKey<FormState>();
  String        _firstName = "_";
  String        _lastName = "_";
  String        _link = "_";
  List<String>  _skillsList = [];
  List<String>  _hobbiesList = [];

  Widget build(BuildContext context) {
    final humanData = Provider.of<DataProvider>(context, listen: false);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    _validateName(String value) {
      if (value.isEmpty)
        return ("Нет имени");
      if (value.contains('@'))
        return ("Только буквы");
      return null;
    }
    _validateLastName(String value) {
      if (value.isEmpty)
        return ("Нет фамилии");
      if (value.contains('@'))
        return ("Только буквы");
      return null;
    }
    _validateLink(String value) {
      return null;
    }
    _validateLists(String value) {
      if (value.isEmpty)
        return ("Без этого никак!");
      return null;
    }
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            width: _width,
            height: _height,
            padding: EdgeInsets.all(_width * 0.05),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: CircleAvatar(
                            maxRadius: 500,
                            backgroundImage: AssetImage("assets/images/cat.png"),
                          ),
                        ),
                      ),
                      Spacer(flex: 1,),
                      Expanded(
                        flex: 10,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'Как зовут человека?',
                                  labelText: 'Имя',
                                ),
                                onSaved: (String value) {
                                  _firstName = value.capitalize();
                                },
                                validator: _validateName,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'Фамилия человека?',
                                  labelText: 'Фамилия',
                                ),
                                onSaved: (String value) {
                                  _lastName = value.capitalize();
                                },
                                validator: _validateLastName,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.link),
                                  hintText: 'Ссылка для связи?',
                                  labelText: 'Ссылка',
                                ),
                                onSaved: (String value) {
                                  _link = value.replaceAll(RegExp(r" +$"), "").toLowerCase();
                                },
                                validator: _validateLink,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.star),
                      hintText: 'Навыки человека?',
                      labelText: 'Навыки',
                    ),
                    onSaved: (String value) => _skillsList = value.toSkillsList(),
                    validator: _validateLists,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.star_border_purple500_sharp),
                      hintText: 'Хобби человека?',
                      labelText: 'Хобби',
                    ),
                    onSaved: (String value) => _hobbiesList = value.toSkillsList(),
                    validator: _validateLists,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: IconButton(
                    icon: Icon(Icons.check),
                    iconSize: _width * 0.2,
                    color: MyColors.purple,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Scaffold
                            .of(context)
                            .showSnackBar(SnackBar(
                            backgroundColor: MyColors.lightPink,
                            content: Text('Идёт сохранение..')
                        ));
                        humanData.addHuman(Human(
                          _firstName,
                          _lastName,
                          _link,
                          _skillsList,
                          _hobbiesList,
                        ));
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: _width,
            height: _height * 0.2,
          ),
        ],
      ),
    );
  }
}
