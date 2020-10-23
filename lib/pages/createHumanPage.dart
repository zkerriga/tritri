import 'package:flutter/material.dart';
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
      body: CreateHumanForm(),
    );
  }
}

class CreateHumanForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateHumanState();
}

class PhotoBlock extends StatelessWidget {
  static const String _catImageURL = 'https://i.pinimg.com/originals/f4/d2/96/f4d2961b652880be432fb9580891ed62.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          Container(
            margin: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
            height: 120,
            width: 120,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(_catImageURL),
            ),
          ),
          Row(
              children: [
                IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.file_download),
                  onPressed: null
                ),
                IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.camera),
                  onPressed: null
                ),
              ],
            ),
        ],
      ),
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

    _validateName(String value) {
      if (value.isEmpty)
        return ("Стоит добавить имя");
      if (value.contains('@'))
        return ("Имя должно содержать только буквы");
      return null;
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              PhotoBlock(),
              Container(
                height: 120,
                width: 250,
                child: TextFormField(
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
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.check),
            iconSize: 50,
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
        ],
      ),
    );
  }
}
