import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/myColors.dart';
import 'package:tritri/widgets/itemHuman.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final humanData = Provider.of<DataProvider>(context);

    /*
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Flutter SQLite")),
        body: FutureBuilder<List<Client>>(
          future: DBProvider.db.getAllClients(),
          builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Client item = snapshot.data[index];
                  return ListTile(
                    title: Text(item.lastName),
                    leading: Text(item.id.toString()),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        DBProvider.db.blockClient(item);
                        setState(() {});
                      },
                      value: item.blocked,
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Client rnd = testClients[math.Random().nextInt(testClients.length)];
            await DBProvider.db.newClient(rnd);
            setState(() {});
          },
        ),
      );
    }*/
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
          humanData.addHuman(Human(DateTime.now().millisecond.toString(), 'Test', 't.me/test', ['skill1', 'skill2'], ['hobbie1', 'hobbie2', 'hobbie3']));
          //TODO: добавить действие на нажатие кнопки
        },
        elevation: 5,
        tooltip: "Добавить карточку",
      ),
    );
  }
}
