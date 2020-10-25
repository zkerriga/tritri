import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tritri/models/human.dart';

import 'skillContainer.dart';

class ItemHuman extends StatelessWidget {
  final double width;
  final double height;
  const ItemHuman({
    Key key,
    @required this.width,
    @required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final human = Provider.of<Human>(context, listen: false);

    return Container(
      padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: CircleAvatar(
                maxRadius: 500,
                backgroundImage: AssetImage("assets/images/cat.png"),
              ),
            )
          ),
          Expanded(
            flex: 5,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${human.firstName} ${human.lastName}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SkillBox(skillsList: human.skills, maxLines: 1,),
                  ),
                  Expanded(
                    flex: 1,
                    child: SkillBox(skillsList: human.hobbies, maxLines: 1,),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
