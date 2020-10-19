import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tritri/myColors.dart';
import 'package:tritri/pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriTri',
      theme: ThemeData(
        primarySwatch: MyColors.palette,
        backgroundColor: MyColors.white,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        )
      ),
      home: HomePage(),
    );
  }
}