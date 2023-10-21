import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_apps/utils/const.dart';
import 'package:fyp_apps/widgets/custom_clipper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp_apps/utils/function.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class GrafScreen extends StatefulWidget {
  @override
  _GrafScreenState createState() => _GrafScreenState();
}


class _GrafScreenState extends State<GrafScreen> {


  var email="";
  var displayDate="";
  DateTime selectedDate = DateTime.now();
  TextEditingController inputGulaController = TextEditingController();
  List<Map<String, dynamic>> apiData = [
    {'seb_sarapan': 0.0, 'sel_sarapan': 0.0, 'seb_tgh': 0.0, 'sel_tgh': 0.0, 'seb_mlm': 0.0, 'sel_mlm': 0.0},
  ];

  void initState() {
    super.initState();
    //getStringData(widget.p);
    //getUserData();
    checkingCurrentSession();
  }

  checkingCurrentSession()async{


    SharedPreferences prefs = await SharedPreferences.getInstance();
    screenLoadingx(context, "Please Wait..", "Try to retrive data..", false, false, true);
    setState(() {
      //var jwtToken = prefs.getString("token");
      //name = prefs.getString("localname").toString();
      email = prefs.getString("localemail").toString();
    });
    //logPrintOut("home:line 44");
    //logPrintOut("checking current session..");
    Navigator.pop(context);
    getRekodData(email,formatDate(selectedDate));

  }


  getRekodData(paramemail,paramdate)async{
    screenLoadingx(context, "Please Wait..", "Try to comunicate with server..", false, false, true);
    var dataX={
      "email":paramemail,
      "tarikh_rekod":paramdate
    };
    print("jjjjj");
    print(dataX);
    if (this.mounted) {
      var dataReturn= await fetchData("fetchData","callrekod",dataX);
      print("00000000");
      print(dataReturn);
      if(dataReturn.length>0){
        print(dataReturn.length);
        setState(() {
          apiData = [
            {'seb_sarapan': double.parse(dataReturn[0]['seb_sarapan']) , 'sel_sarapan': double.parse(dataReturn[0]['sel_sarapan']) , 'seb_tgh': double.parse(dataReturn[0]['seb_tgh']) , 'sel_tgh': double.parse(dataReturn[0]['sel_tgh']) , 'seb_mlm': double.parse(dataReturn[0]['seb_mlm']) , 'sel_mlm': double.parse(dataReturn[0]['sel_mlm']) },
          ];
        });
        Navigator.of(context, rootNavigator: true).pop();
      }else{
        setState(() {
          apiData = [
            {'seb_sarapan': 0.0, 'sel_sarapan': 0.0, 'seb_tgh': 0.0, 'sel_tgh': 0.0, 'seb_mlm': 0.0, 'sel_mlm': 0.0},
          ];
          displayDate=paramdate;
        });
        Navigator.of(context, rootNavigator: true).pop();
      }

    }


  }



  double getMinimumYValue() {
    double minValue = double.infinity;
    for (var dataPoint in apiData[0].values) {
      if (dataPoint is double) {
        if (dataPoint < minValue) {
          minValue = dataPoint;
        }
      }
    }
    return minValue;
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light( primary: Constants.darkGreen,),
            // Change the primary color
            // accentColor: Colors.blue, // Change the accent color
            dialogBackgroundColor: Colors.white, // Change the background color
            textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.red), // Change text selection color
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              buttonColor: Colors.green, // Change button color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        displayDate=formatDate(selectedDate);

      });

      getRekodData(email,formatDate(selectedDate));
    }
  }





  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

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
            padding: EdgeInsets.all(15),

            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[

                Container(
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                  ),
                  //height: 200,
                  child: Column(

                    children: [

                      SizedBox(height: 15, ),

                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap:(){
                                  _selectDate(context);
                                },
                                child: Icon(
                                    Icons.calendar_today_sharp,
                                    size: 40.0,
                                    color: Constants.textPrimary
                                ),
                              ),
                              SizedBox( width: 5,),

                              Text('${displayDate}',
                                style: TextStyle(
                                  color: Constants.textPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // added
                //),

                SizedBox(height:20),
                // InkWell(

                Container(
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),

                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),

                  height: 500,
                  child: Center(
                      child: Container(
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(minimum: getMinimumYValue()), // Set the minimum value here

                            series: <ChartSeries>[
                              LineSeries<ChartData, String>(
                                markerSettings:const MarkerSettings(
                                  isVisible: true, // Set to true to display markers
                                  shape: DataMarkerType.rectangle, // Marker shape (you can change this)
                                  width: 10.0, // Marker width
                                  height: 10.0, // Marker height
                                ),
                                name: "Graf Bacaan Gula",
                                xAxisName: "Waktu",
                                yAxisName: "mmol/L",
                                dataSource: [
                                  ChartData('Sebelum Sarapan', apiData[0]['seb_sarapan'].toDouble(), Colors.red),
                                  ChartData('Selepas Sarapan', apiData[0]['sel_sarapan'].toDouble(), Colors.yellow),
                                  ChartData('Sebelum T.hari', apiData[0]['seb_tgh'].toDouble(), Colors.blue),
                                  ChartData('Selepas T.hari', apiData[0]['sel_tgh'].toDouble(), Colors.green),
                                  ChartData('Sebelum Mlm', apiData[0]['seb_mlm'].toDouble(), Colors.purple),
                                  ChartData('Selepas Mlm', apiData[0]['sel_mlm'].toDouble(), Colors.pink),
                                ],
                                // Bind the color for all the data points from the data source
                                pointColorMapper:(ChartData data, _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                width: 5.0,
                              )
                            ],
                            /*legend: Legend(
                  isVisible: true, // Set to true to display the legend
                  position: LegendPosition.right, // Position of the legend
                ),*/
                            tooltipBehavior: TooltipBehavior(enable: true),
                          )
                      )
                  )

                ),
                /*onTap: (){
                  // int tappedIndex = DefaultTabController.of(context)!.index;
                   _AlertModalBottomSheet(context);
                 },*/
                //),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ],
      ),
    );
  }


}
class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}