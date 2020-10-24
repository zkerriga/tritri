import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/myColors.dart';
import 'package:tritri/widgets/humanItemView.dart';
import 'package:tritri/widgets/itemHuman.dart';
import 'package:tritri/pages/createHumanPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final humanData = Provider.of<DataProvider>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('TriTri'),
        backgroundColor: MyColors.lightBlue,
      ),
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Container(
          color: MyColors.white,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: humanData.items.length,
            itemBuilder: (context, int index) =>
              ChangeNotifierProvider.value(
                value: humanData.items[index],
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => HumanItemView(
                        human: humanData.items[index],
                        width: _width * 0.8,
                        height: _height * 0.8,
                      ),
                    );
                  },
                  child: Container(
                    color: MyColors.white,
                    height: _height * 0.15,
                    margin: EdgeInsets.only(bottom: _height * 0.005, top: _height * 0.005),
                    child: ItemHuman(width: _width, height: _height * 0.15,),
                  ),
                ),
              ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // humanData.deleteAll(44213); //TODO: special for delete all!
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Container(
                height: _height,
                width: _width,
                child: CreateHumanPage(),
              ),
            ),
          );
        },
        elevation: 5,
        tooltip: "Добавить карточку",
      ),
    );
  }
}
