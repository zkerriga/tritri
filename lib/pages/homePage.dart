import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/models/myColors.dart';
import 'package:tritri/widgets/bottomFAButtons.dart';
import 'package:tritri/widgets/humanBuilder.dart';
import 'package:tritri/widgets/myAppBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final humanData = Provider.of<DataProvider>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: getMyAppBar(context),
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Container(
          color: MyColors.white,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: humanData.items.length,
            itemBuilder: (context, int index) =>
              HumanBuilder(
                human: humanData.items[index],
                width: _width,
                height: _height,
              ),
          ),
        ),
      ),
      floatingActionButton: BottomFAButtons(),
    );
  }
}
