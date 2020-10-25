import 'dart:io';
import 'package:flutter/material.dart';

import 'package:tritri/models/myColors.dart';
import 'package:tritri/database/databaseHelper.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Синхронизация',
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
          child: Column(
            children: [
              SizedBox(height: 20,),
              Icon(
                Icons.error_outline,
                color: MyColors.purple,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text("Синхронизация пока не работает.\n\nНо базу данных можно достать или положить вручную.\nОна должна храниться во внутренней памяти телефона по данному пути:"),
              ),
              Divider(),
              Text("${DBHelper.normalDatabasePath}"),
              Divider(),
            ],
          )
        ),
      ),
    );
  }
}
