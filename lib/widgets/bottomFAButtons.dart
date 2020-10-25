import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:provider/provider.dart';

import 'package:tritri/pages/createHumanPage.dart';
import 'package:tritri/models/myColors.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/database/databaseHelper.dart';

import 'humanBuilder.dart';

class BottomFAButtons extends StatelessWidget {
  const BottomFAButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final humanData = Provider.of<DataProvider>(context, listen: false);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final _iconSize = _width * 0.18;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: _iconSize,
          height: _iconSize,
          child: RawMaterialButton(
            fillColor: MyColors.white,
            splashColor: MyColors.lightBlue,
            shape: CircleBorder(),
            child: Icon(
              Icons.search_rounded,
              size: _iconSize * 0.5,
              color: MyColors.pink,
            ),
            onPressed: () => showSearch(
              context: context,
              delegate: SearchPage<Human>(
                items: humanData.items,
                searchLabel: "Поиск",
                suggestion: Center(
                  child: Text("Сейчас найдём ;)"),
                ),
                failure: Center(
                  child: Text("Никого :("),
                ),
                filter: (Human human) => [
                  human.firstName,
                  human.lastName,
                  human.link,
                  human.getSkillsString(),
                  human.getHobbiesString(),
                ],
                builder: (Human human) =>
                    HumanBuilder(
                        human: human,
                        width: _width,
                        height: _height,
                    ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: _iconSize,
          height: _iconSize,
          child: RawMaterialButton(
            fillColor: MyColors.white,
            splashColor: MyColors.lightBlue,
            shape: CircleBorder(),
            child: Icon(
              Icons.add_rounded,
              size: _iconSize * 0.5,
              color: MyColors.pink,
            ),
            onPressed: () {
              // humanData.deleteAll(44213); //TODO: special for delete all!
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CreateHumanPage(),
              ),
              );
            },
          ),
        ),
      ],
    );
  }
}
