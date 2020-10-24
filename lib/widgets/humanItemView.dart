import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/myColors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:tritri/database/databaseHelper.dart';

class _SkillBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.pink,
    );
  }
}


class HumanItemView extends StatelessWidget {
  final double width;
  final double height;
  final Human human;
  const HumanItemView({Key key, this.human, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String _catImageURL = 'https://i.pinimg.com/originals/f4/d2/96/f4d2961b652880be432fb9580891ed62.png';
    final humansData = Provider.of<DataProvider>(context);

    return Dialog(
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
          top: height * 0.05,
          bottom: height * 0.05,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      maxRadius: 500,
                      backgroundImage: NetworkImage(_catImageURL),
                    )
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          human.firstName,
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          human.lastName,
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: human.link,
                            style: TextStyle(color: MyColors.purple),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch("https://${human.link}");
                              },
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: _SkillBox(),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: FlatButton(
                        onPressed: () {},
                        child: Text("Редактировать")
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      color: MyColors.purple,
                      onPressed: () {
                        humansData.deleteHuman(human.id);
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
