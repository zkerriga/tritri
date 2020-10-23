import 'package:flutter/material.dart';
import 'package:tritri/models/human.dart';

class HumanItemView extends StatelessWidget {
  final double width;
  final double height;
  final Human human;
  const HumanItemView({Key key, this.human, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: height,
        width: width,
        child: Column(

        )
      ),
    );
  }
}
