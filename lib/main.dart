import 'package:bitcointicker/price_screen_ios.dart';
import 'package:bitcointicker/price_screen_ios_android.dart';
import 'package:flutter/material.dart';
import 'price_screen_android.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen3(),
    );
  }
}
