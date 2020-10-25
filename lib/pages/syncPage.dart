import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tritri/models/myColors.dart';
import 'package:tritri/widgets/myAppBar.dart';
import 'package:tritri/database/databaseHelper.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({Key key}) : super(key: key);

  Future<String> getPath() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return documentsDirectory.absolute.path;
  }

  @override
  Widget build(BuildContext context) {
    Future<String> path = getPath();

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
                child: Text("Синхронизация пока не работает.\n\nНо базу данных можно достать или положить вручную.\nОна должна храниться по данному пути:"),
              ),
              Divider(),
              FutureBuilder<String>(
                future: path,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("${snapshot.data}/${DBHelper.mainTableName}.db");
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
              Divider(),
            ],
          )
        ),
      ),
    );
  }
}
