import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:tritri/models/myColors.dart';
import 'package:tritri/widgets/myAppBar.dart';

class YandexDiskPage extends StatelessWidget {
  const YandexDiskPage({Key key}) : super(key: key);

  Future<String> fetch() async {
    final response =
    await http.get('https://oauth.yandex.ru/authorize?response_type=token&client_id=16b15758122d487795b82c2542de839a');

    return response.statusCode.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Future<String> res = fetch();

    return Scaffold(
      appBar: getMyAppBar(context),
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Container(
          color: MyColors.white,
          child: Column(
            children: [
              Text("Yandex debug page:"),
              Divider(),

              RichText(
                text: TextSpan(
                  text: 'LINK',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16, color: MyColors.purple
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch("https://oauth.yandex.ru/authorize?response_type=token&client_id=16b15758122d487795b82c2542de839a");
                    },
                ),
              ),
              FutureBuilder<String>(
                future: res,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ],
          )
        ),
      ),
    );
  }
}
