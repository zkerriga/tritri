import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tritri/models/human.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:tritri/myColors.dart';

class SkillsContainer extends StatelessWidget {
  final UnmodifiableListView<String> skillsList;
  SkillsContainer({Key key, this.skillsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
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
  const ItemHuman({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final human = Provider.of<Human>(context, listen: false);
    const String _catImageURL = 'https://i.pinimg.com/originals/f4/d2/96/f4d2961b652880be432fb9580891ed62.png';

    return Container(
      height: 100,
      margin: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: NetworkImage(_catImageURL),
                  fit: BoxFit.cover,
                )
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.only(start: 20.0),
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
                Dash(
                  direction: Axis.horizontal,
                  dashLength: 3,
                  dashColor: MyColors.lightPink,
                ),
              ],
            ),
          ),
        ],
      )
    );


/*    return Container(
      width: 150,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(_catImageURL),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('You clicked on ${human.firstName} ${human.lastName}');
                    // TODO: навигация по конкретной карточке с человеком
                  },
                  child: Container(
                    child: Text(
                        '${human.firstName} ${human.lastName}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Skills: ${human.getSkillsString()}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  child: Text(
                    'Hobbies: ${human.getHobbiesString()}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
        ],
      ),
    );*/
  }
}
