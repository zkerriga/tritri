import 'dart:collection';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/myColors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:tritri/database/databaseHelper.dart';

class _SkillBox extends StatelessWidget {
  final UnmodifiableListView<String> skillsList;
  const _SkillBox({Key key, this.skillsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<WidgetSpan> _widgetsList = <WidgetSpan>[];

    skillsList.forEach((skill) {
      _widgetsList.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            padding: const EdgeInsets.all(2.5),
            margin: const EdgeInsets.only(left: 0, top: 3, right: 4, bottom: 3),
            child: Text(skill),
            decoration: BoxDecoration(
              color: MyColors().randomColor(),
              borderRadius: BorderRadius.circular(3.5),
            ),
          ),
        ),
      );
    });
    return Text.rich(
      TextSpan(
        children: _widgetsList,
      ),
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
                    flex: 4,
                    child: CircleAvatar(
                      radius: width / 6,
                      backgroundImage: NetworkImage(_catImageURL),
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
              ),
            ),
            // Expanded(flex: 1, child: Container()),
            Divider(),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Навыки: ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: _SkillBox(skillsList: human.skills,),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Хобби: ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _SkillBox(skillsList: human.hobbies,),
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
                      onPressed: () {
                        humansData.deleteHuman(human.id);
                      },
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
