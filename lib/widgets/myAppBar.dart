import 'package:flutter/material.dart';

import 'package:tritri/models/myColors.dart';

getMyAppBar(BuildContext context) => AppBar(
  title: Text(
      'TriTri',
      style: TextStyle(color: MyColors.black),
  ),
  backgroundColor: MyColors.lightBlue,
  elevation: 1.5,
  actions: [
    IconButton(
      icon: Icon(Icons.lock_open),
      splashColor: MyColors.transparent,
      highlightColor: MyColors.transparent,
      color: MyColors.black,
      onPressed: () {},
    ),
  ],
);
