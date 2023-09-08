import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_apps/utils/const.dart';
import 'package:fyp_apps/widgets/card_items.dart';
import 'package:fyp_apps/widgets/card_main.dart';
import 'package:fyp_apps/widgets/card_section.dart';
import 'package:fyp_apps/widgets/custom_clipper.dart';

class HomeScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.darkGreen,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),

          // BODY
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              children: <Widget>[
                // Header - Greetings and Avatar
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Tetapan Tambahan \nAplikasi",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white
                        ),
                      ),
                    ),
                    CircleAvatar(
                        radius: 26.0,
                        backgroundImage: AssetImage('assets/icons/gear.png')
                    )
                  ],
                ),

                SizedBox(height: 50),


                // Scheduled Activities
             /*   Text("SCHEDULED ACTIVITIES",
                  style: TextStyle(
                      color: Constants.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                  ),
                ),*/

               // SizedBox(height: 20),

                Container(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      /*CardItems(
                        image: Image.asset(
                          'assets/icons/Walking.png',
                        ),
                        title: "BMI",
                        value: "750",
                        unit: "steps",
                        color: Constants.lightYellow,
                        progress: 30,
                      ),*/
                      CardItems(
                        image: Image.asset(
                          'assets/icons/clock2.png',
                        ),
                        title: "Peringatan \nPengambilan Ubat",
                        value: "30",
                        unit: "mins",
                        color: Constants.lightBlue,
                        progress: 0,
                      ),
                      CardItems(
                        image: Image.asset(
                          'assets/icons/bmi2.png',
                        ),
                        title: "BMI",
                        value: "30",
                        unit: "mins",
                        color: Constants.lightBlue,
                        progress: 0,
                      ),
                      CardItems(
                        image: Image.asset(
                          'assets/icons/bp2.png',
                        ),
                        title: "Bacaan Tekanan \nDarah",
                        value: "30",
                        unit: "mins",
                        color: Constants.lightBlue,
                        progress: 0,
                      ),
                      CardItems(
                        image: Image.asset(
                          'assets/icons/info2.png',
                        ),
                        title: "Info Diabetes",
                        value: "30",
                        unit: "mins",
                        color: Constants.lightBlue,
                        progress: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
