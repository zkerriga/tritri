import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/myColors.dart';
import 'package:tritri/widgets/itemHuman.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final humanData = Provider.of<HumansDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('TriTri'),
        backgroundColor: MyColors.lightBlue,
      ),
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.white,
          ),
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              Container(
                child: ListTile(
                  title: Text('Все'),
                  // trailing: Icon(Icons.panorama_horizontal),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                height: 900, //TODO: Размер поля для скрола нужно как-то конкретнее определить
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: humanData.items.length,
                    itemBuilder: (context, int index) =>
                        ChangeNotifierProvider.value(
                            value: humanData.items[index],
                            child: ItemHuman(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //TODO: добавить действие на нажатие кнопки
        },
        elevation: 5,
        tooltip: "Добавить карточку",
      ),
    );
  }
}
