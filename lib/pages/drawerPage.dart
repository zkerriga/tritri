import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tritri/database/databaseHelper.dart';
import 'package:tritri/models/myColors.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key key}) : super(key: key);

  Widget topStatLittleRow(BuildContext context, int number, IconData myIcon) {
    return Row(
      children: [
        Text(
          "$number ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.black,
          ),
        ),
        Icon(
          myIcon,
          size: 20,
          color: MyColors.black,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final humanData = Provider.of<DataProvider>(context, listen: false);
    const String _catImageURL = 'https://i.pinimg.com/originals/f4/d2/96/f4d2961b652880be432fb9580891ed62.png';

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: MyColors.lightBlue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CircleAvatar(
                  minRadius: 50,
                  backgroundImage: NetworkImage(_catImageURL),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: topStatLittleRow(context, humanData.items.length, Icons.person),
                    ),
                    Expanded(
                      flex: 2,
                      child: topStatLittleRow(context, humanData.skillsQuantity, Icons.star),
                    ),
                    Expanded(
                      flex: 2,
                      child: topStatLittleRow(context, humanData.hobbiesQuantity, Icons.star_border),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
