import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tritri/models/human.dart';

class ItemHuman extends StatelessWidget {
  const ItemHuman({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final human = Provider.of<Human>(context, listen: false);
    const String _catImageURL = 'https://i.pinimg.com/originals/f4/d2/96/f4d2961b652880be432fb9580891ed62.png';

    return Container(
      width: 150,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(_catImageURL),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('You clicked on ${human.firstName} ${human.lastName}');
                    // TODO: навигация по конкретной карточке с человеком
                  },
                  child: Container(
                    child: Text(
                        '${human.firstName} ${human.lastName}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Skills: ${human.getSkillsString()}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  child: Text(
                    'Hobbies: ${human.getHobbiesString()}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
