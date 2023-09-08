import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_apps/utils/const.dart';
import 'package:fyp_apps/widgets/custom_clipper.dart';
import 'package:fyp_apps/widgets/grid_item.dart';
import 'package:fyp_apps/screens/grafline.dart';


class DetailScreenx extends StatefulWidget {

  @override
  _DetailScreenxState createState() => _DetailScreenxState();
}

class _DetailScreenxState extends State<DetailScreenx> {



  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    // For Grid Layout
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16, _cellHeight = 150.0;
    int _crossAxisCount = 2;

    double _width = (MediaQuery.of(context).size.width -
        ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double _aspectRatio =
        _width / (_cellHeight + _mainAxisSpacing + (_crossAxisCount + 1));

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
              scrollDirection: Axis.vertical,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Back Button
                        SizedBox(
                          width: 34,
                          child:RawMaterialButton(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                                Icons.arrow_back_ios,
                                size: 15.0,
                                color: Colors.white
                            ),
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                  style: BorderStyle.solid
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Heartbeat",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              mainAxisAlignment: MainAxisAlignment.start,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text("66",
                                  style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white
                                  ),
                                ),

                                SizedBox(width: 10),

                                Text("bpm",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/icons/heartbeatthin.png'),
                        height: 73,
                        width: 80,
                        color: Colors.white.withOpacity(1)
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Chart
                Material(
                  shadowColor: Colors.grey.withOpacity(0.01), // added
                  type: MaterialType.card,
                  elevation: 10, borderRadius: new BorderRadius.circular(10.0),
                  child:
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 600,
                      height: 300,
                      //child: Expanded(
                        child:new Container(
                          child:SimpleTimeSeriesChart.withSampleData()
                         /* LineChart(

                            LineChartData(
                              borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1),),
                                minX: 0,
                                maxX: 10,
                                minY: 0,
                                maxY: 6,
                              lineBarsData: [

                                LineChartBarData(

                                  spots: [
                                    FlSpot(1, 3),
                                    FlSpot(2, 10),
                                    FlSpot(3, 7),
                                    FlSpot(4, 12),
                                    FlSpot(5, 13),
                                    FlSpot(6, 17),
                                    FlSpot(7, 5),
                                    FlSpot(8, 4.5),
                                    FlSpot(9, 20),
                                    FlSpot(10, 5),
                                    FlSpot(11, 7),
                                    FlSpot(12, 22),
                                    FlSpot(13, 9),
                                    FlSpot(14, 6),
                                    FlSpot(15, 4),
                                    FlSpot(16, 6),
                                    FlSpot(17, 4),
                                    FlSpot(18, 9),
                                    FlSpot(18, 7),
                                    FlSpot(19, 7)
                                  ],
    *//*isCurved: true,

                                  colors: gradientColors,
                                  barWidth: 5,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(
                                    show: true,

                                  ),*//*
                                 *//* belowBarData: BarAreaData(
                                    show: true,
                                    colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
                                  ),*//*
                                )
                              ]
                          ),
                          ),*/
                        ),
                     // ),
                    ),
                  ),


                ),
                SizedBox(height: 30),
                Container(
                  child: new GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                      crossAxisSpacing: _crossAxisSpacing,
                      mainAxisSpacing: _mainAxisSpacing,
                      childAspectRatio: _aspectRatio,
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {

                      switch(index) {
                        case 0:
                          return GridItem(
                              status: "Rest",
                              time: "4h 45m",
                              value: "76",
                              unit: "avg bpm",
                              color: Constants.darkGreen,
                              image: null,
                              remarks: "ok"
                          );
                          break;
                        case 1:
                          return GridItem(
                              status: "Active",
                              time: "30m",
                              value: "82",
                              unit: "avg bpm",
                              color: Constants.darkOrange,
                              image: null,
                              remarks: "ok"
                          );
                          break;
                        case 2:
                          return GridItem(
                              status: "Fitness Level",
                              time: "",
                              value: "82",
                              unit: "avg bpm",
                              color: Constants.darkOrange,
                              image: AssetImage("assets/icons/Heart.png"),
                              remarks: "Fit"
                          );
                          break;
                        case 3:
                          return GridItem(
                              status: "Endurance",
                              time: "",
                              value: "82",
                              unit: "avg bpm",
                              color: Constants.darkOrange,
                              image: AssetImage("assets/icons/Battery.png"),
                              remarks: "Ok"
                          );
                          break;
                        default:
                          return GridItem(
                            status: "Rest",
                            time: "4h 45m",
                            value: "76",
                            unit: "avg bpm",
                            image: null,
                            remarks: "ok",
                            color: Constants.darkOrange,
                          );
                          break;
                      }
                    },
                  ),
                ),
                SizedBox(height: 200,)
              ],
            ),
          ),
        ],
      ),
    );
  }


}


