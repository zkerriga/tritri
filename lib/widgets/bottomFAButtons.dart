import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:provider/provider.dart';

import 'package:tritri/pages/createHumanPage.dart';
import 'package:tritri/models/myColors.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/database/databaseHelper.dart';

import 'humanBuilder.dart';

class BottomFAButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final humanData = Provider.of<DataProvider>(context, listen: false);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FloatingActionButton(
          foregroundColor: MyColors.pink,
          backgroundColor: MyColors.white,
          splashColor: MyColors.lightBlue,
          child: Icon(Icons.search),
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
                  humanData: humanData
                ),
            ),
          ),
          heroTag: null,
          tooltip: "Поиск",
          elevation: 3,
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          foregroundColor: MyColors.pink,
          backgroundColor: MyColors.white,
          splashColor: MyColors.lightBlue,
          child: Icon(Icons.add),
          onPressed: () {
            // humanData.deleteAll(44213); //TODO: special for delete all!
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => CreateHumanPage(),
            ),
            );
          },
          elevation: 3,
          tooltip: "Добавить карточку",
          heroTag: null,
        ),
      ],
    );
  }
}
