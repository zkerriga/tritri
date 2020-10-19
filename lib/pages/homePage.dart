import 'package:flutter/material.dart';
import 'package:tritri/myColors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TriTri'),
      ),
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: MyColors.white,
          ),
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              Container(
                child: ListTile(
                  title: Text('Все'),
                  trailing: Icon(Icons.panorama_horizontal),
                ),
              ),
              Container(
                child: Text('[+] Вертикальный список карточек'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
