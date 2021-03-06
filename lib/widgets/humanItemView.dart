import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'package:tritri/models/human.dart';
import 'package:tritri/models/myColors.dart';
import 'package:tritri/database/databaseHelper.dart';

import 'skillContainer.dart';

class HumanItemView extends StatelessWidget {
  final double width;
  final double height;
  final Human human;
  const HumanItemView({
    Key key,
    @required this.human,
    @required this.width,
    @required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final humansData = Provider.of<DataProvider>(context, listen: false);

    return Dialog(
      child: Container(
          padding: EdgeInsets.only(
          left: width * 0.05, right: width * 0.05,
          top: height * 0.05, bottom: height * 0.05,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _TopRow(human: human, width: width, height: height,),
            ),
            Divider(),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Text("Навыки: ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: SkillBox(skillsList: human.skills),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Text("Хобби:    ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SkillBox(skillsList: human.hobbies),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      color: MyColors.purple,
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      color: MyColors.purple,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => _DeleteAlertDialog(human: human, humansData: humansData,),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  final double width;
  final double height;
  final Human human;
  const _TopRow({
    Key key,
    @required this.human,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: CircleAvatar(
            radius: width / 6,
            backgroundImage: AssetImage("assets/images/cat.png"),
          ),
        ),
        Spacer(flex: 1,),
        Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(),
                Text(
                  human.firstName,
                  style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  human.lastName,
                  style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: human.link,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16, color: MyColors.purple
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch("https://${human.link}");
                      },
                  ),
                ),
                SizedBox(),
              ],
            )
        ),
      ],
    );
  }
}

class _DeleteAlertDialog extends StatelessWidget {
  final DataProvider humansData;
  final Human human;
  const _DeleteAlertDialog({
    Key key,
    @required this.human,
    @required this.humansData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Удалить карточку?"),
      content: Text("Карточка будет удалена безвозвратно!"),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Да",
            style: TextStyle(color: MyColors.black),
          ),
          onPressed: () {
            humansData.deleteHuman(human.id);
            Navigator.of(context, rootNavigator: true).pop(0);
            Navigator.of(context, rootNavigator: true).pop(0);
          },
        ),
        FlatButton(
          child: Text(
            "Нет",
            style: TextStyle(color: MyColors.black),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(0);
          },
        ),
      ],
      elevation: 1,
    );
  }
}
