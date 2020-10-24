import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/myColors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final humanData = Provider.of<DataProvider>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Поиск'),
        backgroundColor: MyColors.lightBlue,
      ),
      backgroundColor: MyColors.white,
      resizeToAvoidBottomPadding: false,
      body: Container(),
    );
  }
}
