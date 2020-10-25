import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tritri/models/myColors.dart';

class SkillContainer extends StatelessWidget {
  final String skill;
  const SkillContainer(this.skill, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.5),
      margin: const EdgeInsets.only(left: 0, top: 3, right: 4, bottom: 3),
      child: Text(skill),
      decoration: BoxDecoration(
        color: MyColors().randomColor(),
        borderRadius: BorderRadius.circular(3.5),
      ),
    );
  }
}

class SkillBox extends StatelessWidget {
  final UnmodifiableListView<String> skillsList;
  final int maxLines;
  const SkillBox(this.skillsList, {Key key, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<WidgetSpan> _widgetsList = <WidgetSpan>[];

    skillsList.forEach((skill) {
      _widgetsList.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: SkillContainer(skill),
        ),
      );
    });
    return Text.rich(
      TextSpan(
        children: _widgetsList,
      ),
      maxLines: maxLines,
    );
  }
}
