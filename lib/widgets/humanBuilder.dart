import 'package:flutter/material.dart';
import 'package:tritri/models/myColors.dart';
import 'package:tritri/models/human.dart';
import 'package:provider/provider.dart';
import 'package:tritri/database/databaseHelper.dart';

import 'humanItemView.dart';
import 'itemHuman.dart';

class HumanBuilder extends StatelessWidget {
  final Human human;
  final double width;
  final double height;
  final DataProvider humanData;
  const HumanBuilder({
    Key key,
    @required this.human,
    @required this.width,
    @required this.height,
    @required this.humanData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: human,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => HumanItemView(
              human: human,
              width: width * 0.8,
              height: height * 0.8,
            ),
          );
        },
        child: Container(
          color: MyColors.white,
          height: height * 0.15,
          margin: EdgeInsets.only(bottom: height * 0.005, top: height * 0.005),
          child: ItemHuman(width: width, height: height * 0.15,),
        ),
      ),
    );
  }
}
