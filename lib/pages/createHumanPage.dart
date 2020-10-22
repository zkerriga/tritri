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
  String        _firstName = "_name";
  String        _lastName = "_name2";
  String        _link = "_link";
  List<String>  _skillsList = ["skill1"];
  List<String>  _hobbiesList = ["hobbie1"];

  Widget build(BuildContext context) {
    final humanData = Provider.of<DataProvider>(context);

    return Container(
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
                    hintText: 'Как вас зовут люди?',
                    labelText: 'Имя',
                  ),
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    _firstName = value; //TODO: это не сохраняется
                  },
                  validator: (String value) {
                    return value.contains('@') ? 'Do not use the @ char.' : null;
                  },
                )
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.save),
            iconSize: 50,
            color: MyColors.purple,
            onPressed: () {
              humanData.addHuman(Human(
                _firstName,
                _lastName,
                _link,
                _skillsList,
                _hobbiesList,
              ));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

/*class CreateHumanState extends State {
  final _formKey = GlobalKey<FormState>();
  String        _firstName = "_name";
  String        _lastName = "_name2";
  String        _link = "_link";
  List<String>  _skillsList = ["skill1"];
  List<String>  _hobbiesList = ["hobbie1"];

  Widget build(BuildContext context) {
    final humanData = Provider.of<DataProvider>(context);

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Имя: "),
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty)
                        return ("Нужно заполнить!");
                      _firstName = value;
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text("Фамилия: "),
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty)
                        return ("Нужно заполнить!");
                      _lastName = value;
                      return null;
                    }
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text("Ссылка: "),
                // TextFormField(validator: _validate,)
              ],
            ),
            RaisedButton(
              onPressed: () {
                  humanData.addHuman(Human(_firstName, _lastName, _link, _skillsList, _hobbiesList));
                  Navigator.pop(context);
                },
              child: Text('Готово')
            ),
          ],
        ),
      ),
    );
  }
}*/