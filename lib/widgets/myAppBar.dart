import 'package:flutter/material.dart';
import 'package:tritri/models/myColors.dart';
import 'package:tritri/pages/searchPage.dart';

getMyAppBar(BuildContext context) => AppBar(
  title: Text(
      'TriTri',
      style: TextStyle(color: MyColors.black),
  ),
  backgroundColor: MyColors.lightBlue,
  actions: [
    IconButton(
      icon: Icon(Icons.lock_open),
      splashColor: MyColors.transparent,
      highlightColor: MyColors.transparent,
      color: MyColors.black,
      onPressed: () {},
    ),
/*    IconButton(
      icon: Icon(Icons.search),
      splashColor: MyColors.transparent,
      highlightColor: MyColors.transparent,
      color: MyColors.black,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MySearchPage(),
        ),
        );
      },
    ),*/
  ],
);
