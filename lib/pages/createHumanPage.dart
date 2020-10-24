import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/myColors.dart';

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
      body: CreateHumanForm(),
    );
  }
}

class CreateHumanForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateHumanState();
}

class _PhotoBlock extends StatelessWidget {
  static const String _catImageURL = 'https://i.pinimg.com/originals/f4/d2/96/f4d2961b652880be432fb9580891ed62.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Center(
            child: CircleAvatar(
              maxRadius: 500,
              backgroundImage: NetworkImage(_catImageURL),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: null
              ),
              IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: null
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CreateHumanState extends State {
  final _formKey = GlobalKey<FormState>();
  String        _firstName = "_";
  String        _lastName = "_";
  String        _link = "_";
  List<String>  _skillsList = [];
  List<String>  _hobbiesList = [];

  Widget build(BuildContext context) {
    final humanData = Provider.of<DataProvider>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    _validateName(String value) {
      if (value.isEmpty)
        return ("Стоит добавить имя");
      if (value.contains('@'))
        return ("Только буквы");
      return null;
    }
    _validateLastName(String value) {
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
    List<String> _toSkillsList(String value) {
      const String _splitter = " ";
      return value
          .replaceAll(RegExp(r"^[ ,.]+"), "")
          .replaceAll(RegExp(r"[ ,.]+$"), "")
          .toLowerCase()
          .replaceAll(RegExp(r"[ ,.]+"), _splitter)
          .split(_splitter);
    }
    return Form(
      key: _formKey,
      child: Container(
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
                    flex: 1,
                    child: _PhotoBlock(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
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
                              _firstName = value;
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
                              _lastName = value;
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
                              _link = value;
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
            Expanded(
              flex: 1,
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.star),
                  hintText: 'Навыки человека?',
                  labelText: 'Навыки',
                ),
                onSaved: (String value) => _skillsList = _toSkillsList(value),
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
                onSaved: (String value) => _hobbiesList = _toSkillsList(value),
                validator: _validateLists,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 3,
              child: IconButton(
                icon: Icon(Icons.check),
                iconSize: _width * 0.2,
                color: MyColors.purple,
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
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
    );
  }
}
