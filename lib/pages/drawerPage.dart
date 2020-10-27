import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/models/myColors.dart';
import 'package:tritri/pages/helpProjectPage.dart';
import 'package:tritri/pages/syncPage.dart';
import 'package:tritri/pages/notCompletePage.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key key}) : super(key: key);

  Widget topStatLittleRow(BuildContext context, int number, IconData myIcon) {
    return Row(
      children: [
        Text(
          "$number ",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: MyColors.black,
          ),
        ),
        Icon(
          myIcon,
          size: 18,
          color: MyColors.black,
        ),
      ],
    );
  }

  Widget drawerListRow(BuildContext context, IconData myIcon, String myText, Function tapFunc) {
    return GestureDetector(
      onTap: tapFunc,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              myIcon,
              size: 18,
              color: MyColors.gray,
            ),
            SizedBox(width: 18,),
            Text(
              myText,
              style: TextStyle(
                color: MyColors.black,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final humanData = Provider.of<DataProvider>(context, listen: false);
    final Function openSyncPage = () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => SyncPage(),
      ));
    };
    final Function openHelpProjectPage = () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => HelpProjectPage(),
      ));
    };
    final Function openNotCompletePage = (String title) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => NotCompletePage(title: title),
      ));
    };
    return Drawer(
      elevation: 4,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: MyColors.lightBlue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CircleAvatar(
                  minRadius: 50,
                  backgroundImage: AssetImage("assets/images/cat.png"),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: topStatLittleRow(context, humanData.items.length, Icons.person),
                    ),
                    Expanded(
                      flex: 2,
                      child: topStatLittleRow(context, humanData.skillsQuantity, Icons.star),
                    ),
                    Expanded(
                      flex: 2,
                      child: topStatLittleRow(context, humanData.hobbiesQuantity, Icons.star_border),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
              ],
            ),
          ),
          drawerListRow(context, Icons.sync, "Синхронизация", openSyncPage,),
          drawerListRow(context, Icons.palette, "Кастомизация", () {openNotCompletePage("Кастомизация");},),
          drawerListRow(context, Icons.settings, "Настройки", () {openNotCompletePage("Настройки");},),
          drawerListRow(context, Icons.change_history, "Достижения", () {openNotCompletePage("Достижения");},),
          drawerListRow(context, Icons.payment, "Помочь проекту", openHelpProjectPage,),
          drawerListRow(context, Icons.question_answer, "Обратная связь", () {openNotCompletePage("Обратная связь");},),
        ],
      ),
    );
  }
}
