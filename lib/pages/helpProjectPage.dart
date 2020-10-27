import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tritri/models/myColors.dart';

class HelpProjectPage extends StatelessWidget {
  const HelpProjectPage({
    Key key,
  }) : super(key: key);

  Widget getPoint(String message) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 4,
          backgroundColor: MyColors.gray,
        ),
        SizedBox(width: 6,),
        Text(message),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Помочь проекту",
          style: TextStyle(color: MyColors.black),
        ),
        backgroundColor: MyColors.lightBlue,
        elevation: 1.5,
      ),
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: MyColors.white,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Icon(
                  Icons.star,
                  color: MyColors.purple,
                  size: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text("Данный проект находится на стадии старта, хотя ты уже можешь пользоваться основными функциями приложения c:\n\n"
                      "Впереди ещё много работы, я планирую реализовать:"),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: getPoint("Синхронизацию с облаком"),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: getPoint("Ускоренное заполнение карточки"),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: getPoint("Удобный формат набора навыков с подсказками"),
                ),
                SizedBox(height: 20,),
                Text("Если тебе нравится идея приложения, ты можешь помочь его развитию, перечислив любую сумму на карту:"),
                SizedBox(height: 20,),
                Expanded(
                    child: FlatButton(
                      onPressed: () {Clipboard.setData(ClipboardData(text: "4817760232753115"));},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.purple, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Spacer(flex: 1,),
                            Text(
                              "нажми, чтобы скопировать",
                              style: TextStyle(color: MyColors.purple, fontSize: 10),
                            ),
                            Text(
                              "4817 7602 3275 3115",
                              style: TextStyle(color: MyColors.purple, fontSize: 20),
                            ),
                            Spacer(flex: 1,),
                          ],
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
