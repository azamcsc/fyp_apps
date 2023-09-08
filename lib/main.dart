import 'package:flutter/material.dart';
import 'package:fyp_apps/screens/home_screen.dart';
import 'package:fyp_apps/utils/const.dart';
import 'package:fyp_apps/screens/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: Constants.lighTheme(context),
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}
