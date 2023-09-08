import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fyp_apps/screens/detail_screen.dart';
import 'package:fyp_apps/screens/home2.dart';
import 'package:fyp_apps/screens/zzzzz.dart';
import 'package:fyp_apps/utils/const.dart';
import 'package:fyp_apps/screens/gggg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
var listx;
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List pages = [
    MyRoute(
      iconData: Icons.add,
      page: DetailScreen(),
    ),
    MyRoute(
      iconData: Icons.compare_arrows,
      page: ItemDetailsPage(),//DetailScreenx(),
    ),
    MyRoute(
      iconData: Icons.compare_arrows,
       page:HomeScreen2(),// Chart(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Constants.backgroundColor,// Colors.white,// Color(0xFFF7030a0),



      body: pages[_page].page,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/icons/6023510.png'),
              height: 40,
              width: 40,
              color: Colors.white.withOpacity(1)
          ),
          //Icon(FontAwesomeIcons., size: 30,color: Colors.white,),
          Icon(Icons.bar_chart, size: 40,color: Colors.white,),
          Icon(Icons.settings, size: 40,color: Colors.white,),
        ],
        color: Constants.darkGreen,//Colors.white,
        buttonBackgroundColor: Constants.darkGreen,
        backgroundColor:Colors.transparent,// Constants.backgroundColor,//Constants.darkGreen,//Color(0xFFF7030a0),
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),

    );
  }
}

class MyRoute {
  final IconData iconData;
  final Widget page;

  MyRoute({this.iconData, this.page});
}