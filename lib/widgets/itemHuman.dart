import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/models/human.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:tritri/myColors.dart';

class SkillsContainer extends StatelessWidget {
  final UnmodifiableListView<String> skillsList;
  SkillsContainer({Key key, this.skillsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 26,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: skillsList.length,
        itemBuilder: (context, int skillIndex) {
          return Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.only(left: 0, top: 3, right: 3, bottom: 3),
            child: Text(skillsList[skillIndex]),
            decoration: BoxDecoration(
              color: (skillIndex % 2 == 0) ? MyColors.lightBlue : MyColors.lightPink,
              borderRadius: BorderRadius.circular(3.5),
            ),
          );
        },
      ),
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
                    Container(
                      child: Text(
                        '${human.firstName} ${human.lastName}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SkillsContainer(skillsList: human.skills,),
                    SkillsContainer(skillsList: human.hobbies,),
                    Container(
                      width: 10,
                      height: 10,
                      color: MyColors.pink,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        iconSize: 10,
                        color: MyColors.purple,
                        onPressed: () {
                          humansData.deleteHuman(human.id);
                        },
                      ),
                    ),
                    Dash(
                      direction: Axis.horizontal,
                      dashLength: 3,
                      dashColor: MyColors.lightPink,
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
