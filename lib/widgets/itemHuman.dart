import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tritri/models/human.dart';

class ItemHuman extends StatelessWidget {
  const ItemHuman({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final human = Provider.of<Human>(context, listen: false);

    return Container(
      width: 150,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage('https://i.pinimg.com/originals/f4/d2/96/f4d2961b652880be432fb9580891ed62.png'),
                    fit: BoxFit.cover,
                  )

                ),
              ),
              Container(
                child: Text(
                    '${human.firstName}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
