import 'package:flutter/material.dart';

import 'package:tritri/models/myColors.dart';

class NotCompletePage extends StatelessWidget {
  final String title;
  const NotCompletePage({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: MyColors.black),
        ),
        backgroundColor: MyColors.lightBlue,
        elevation: 1.5,
      ),
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(20),
            color: MyColors.white,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Icon(
                    Icons.self_improvement,
                    color: MyColors.purple,
                    size: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text("Страница в разработке"),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
