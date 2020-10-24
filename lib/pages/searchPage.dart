import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/models/human.dart';
import 'package:tritri/myColors.dart';
import 'package:search_page/search_page.dart';
import 'package:tritri/widgets/humanItemView.dart';
import 'package:tritri/widgets/itemHuman.dart';

class MySearchPage extends StatelessWidget {
  const MySearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final humanData = Provider.of<DataProvider>(context, listen: false);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: ListView.builder(
        itemCount: humanData.items.length,
        itemBuilder: (context, index) {
          final Human human = humanData.items[index];
          return ListTile(
            title: Text(human.firstName),
            subtitle: Text(human.lastName),
            trailing: Text('yo'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Search people',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Human>(
            items: humanData.items,
            searchLabel: 'Search people',
            suggestion: Center(
              child: Text('Filter people by name, surname or age'),
            ),
            failure: Center(
              child: Text('No person found :('),
            ),
            filter: (Human human) => [
              human.firstName,
              human.lastName,
              human.skills.toString(),
              human.hobbies.toString(),
            ],
            builder: (Human human) => ListTile(
              title: Text(human.firstName),
              subtitle: Text(human.lastName),
              trailing: Text('yo'),
            ),
          ),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}
