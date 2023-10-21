import 'package:flutter/material.dart';
import 'package:fyp_apps/screens/home_screen.dart';
import 'package:fyp_apps/utils/const.dart';
//import 'package:fyp_apps/screens/menu.dart';
import 'package:fyp_apps/screens/login.dart';
import 'package:fyp_apps/screens/menu.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
// Define named routes and their associated widgets
        '/coreHome': (context) => BottomNavBar(),
        '/login': (context) => MyLoginPage(),
//'/class': (context) =>KelasListScreen(),// ListClassApp(),
//'/login': (context) => MaanSigninScreen(isClient: true),
// '/login': (context) => ThirdScreen(),
      },
      title: Constants.appName,
      theme: Constants.lighTheme(context),
      home:MyLoginPage(),
    );
  }
}


