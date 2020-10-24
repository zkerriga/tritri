import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/myColors.dart';

class SkillsContainer extends StatelessWidget {
  final UnmodifiableListView<String> skillsList;
  const SkillsContainer({Key key, this.skillsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetsList = <Widget>[];
    skillsList.forEach((skill) {
      _widgetsList.add(Container(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.only(left: 0, top: 3, right: 3, bottom: 3),
        child: Text(skill),
        decoration: BoxDecoration(
          color: MyColors().randomColor(),
          borderRadius: BorderRadius.circular(3.5),
        ),
      ));
    });
    return Row(
      children: _widgetsList,
    );
  }
}

class ItemHuman extends StatelessWidget {
  final double width;
  final double height;
  const ItemHuman({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final humansData = Provider.of<DataProvider>(context);
    final human = Provider.of<Human>(context, listen: false);
    const String _catImageURL = 'https://i.pinimg.com/originals/f4/d2/96/f4d2961b652880be432fb9580891ed62.png';

    return Container(
      padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text("${_width.round()}-${_height.round()}"),
          Expanded(
            flex: 2,
            child: Center(
              child:CircleAvatar(
                maxRadius: 500,
                backgroundImage: NetworkImage(_catImageURL),
              ),
            )
          ),
          Expanded(
            flex: 5,
            child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*Container(
                      child: Text(
                        '${human.firstName} ${human.lastName}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),*/
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          '${human.firstName} ${human.lastName}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SkillsContainer(skillsList: human.skills,),
                    ),
                    Expanded(
                      flex: 2,
                      child: SkillsContainer(skillsList: human.hobbies,),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
