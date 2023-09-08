import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// JSON format
// {"Response":"Success","Type":100,"Aggregated":false,"Data":
// [{"time":1279324800,"close":0.04951,"high":0.04951,"low":0.04951,"open":0.04951,"volumefrom":20,"volumeto":0.9902},

/// Time-series data type.
class TimeSeriesPrice {
  final DateTime time;
  final double price;
  TimeSeriesPrice(this.time, this.price);
}

class ItemDetailsPage extends StatefulWidget {
  @override
  _ItemDetailsPageState createState() => new _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  String url =
      "https://azamrazali.com/api.php";

  List dataJSON;
  var DateTouch;
  var MolTouch;
  var MolTouch2;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  Future<String> getCoinsTimeSeries() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    if (this.mounted) {
      this.setState(() {
        var extractdata = json.decode(response.body);
        dataJSON = extractdata["Data"];
      });
    }
  }

  @override
  void initState() {
    this.getCoinsTimeSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Rumusan Laporan")),
      body: chartWidget(),
    );
  }

  UpdateValue(DateTouch,MolTouch){
    final DateTime now = MolTouch;
    setState(() {
      MolTouch2 = formatter.format(now);
      DateTouch = DateTouch;//model.selectedSeries[0].measureFn(model.selectedDatum[0].index);
    });
  }

  Widget chartWidget() {
    List<TimeSeriesPrice> tsdata = [];
    if (dataJSON != null) {
      for (Map m in dataJSON) {
        try {
          tsdata.add(new TimeSeriesPrice(
             // new DateTime.fromMillisecondsSinceEpoch(m['time'] * 1000, isUtc: true), m['close']+.0));
          //new DateTime.fromMillisecondsSinceEpoch(m['time'] * 1000, isUtc: true), m['close']+.0));
          new DateTime(m['y'] , m['m'] , m['d'] ), m['mmo'] ));
        } catch (e) {
          print(e.toString());
        }
      }
    } else {
      // Dummy list to prevent dataJSON = NULL
      tsdata.add(new TimeSeriesPrice(new DateTime.now(), 0.0));
    }

    var series = [
      new charts.Series<TimeSeriesPrice, DateTime>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesPrice coinsPrice, _) => coinsPrice.time,
        measureFn: (TimeSeriesPrice coinsPrice, _) => coinsPrice.price,
        data: tsdata,
      ),
    ];

    var chart = new charts.TimeSeriesChart(
      series,
      animate: true,
    defaultRenderer:
     charts.LineRendererConfig(
        // Dot size
        radiusPx: 7.0,
        stacked: true,
        // line width
        strokeWidthPx: 3.0,
        // Whether to display the line
        includeLine: true,
        // Whether to display dots
        includePoints: true,
        // Whether to display the included area
        includeArea: true,
        // Area color transparency 0.0-1.0
        areaOpacity: 0.3 ,
      ),
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      domainAxis: charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
            format: 'd MMM',
            transitionFormat: 'd MMM',

          ),
        ),
      ),
      behaviors: [
        /* LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer();
        ),*/
        // Adding this behavior will allow tapping a bar to center it in the viewport
        charts.SlidingViewport(
          charts.SelectionModelType.action,
        ),
        charts.PanBehavior(),
        charts.PanAndZoomBehavior(),
        /*charts.SeriesLegend(
          position: charts.BehaviorPosition.top,
          horizontalFirst: true,
          cellPadding: EdgeInsets.only(left: 80, top: 10, bottom: 4.0),
        ),*/
       /* charts.SelectNearest(
            eventTrigger: charts.SelectionTrigger.tap
        ),*/
       /* charts.LinePointHighlighter(
          symbolRenderer: CustomCircleSymbolRenderer(size: size),
        ),*/

      ],
      selectionModels: [
        new charts.SelectionModelConfig(
            changedListener: (model) {

              print("xxxxxxxxxxxxxxxxxxxxxx");
               DateTouch = model.selectedSeries[0].measureFn(model.selectedDatum[0].index);
               MolTouch=  model.selectedSeries[0].domainFn(model.selectedDatum[0].index);


              print( model.selectedSeries[0].measureFn(model.selectedDatum[0].index));
              print( model.selectedSeries[0].domainFn(model.selectedDatum[0].index));
             UpdateValue(DateTouch,MolTouch);

              print("xxxxxxxxxxxxxxxxxxxx");
            }
        )
      ],
    );

    return new Container(

      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Purata Bacaan Mol",style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0,),),
          Text("Avg Mol:$DateTouch"),
          Text("Date:$MolTouch2"),

          /*new Padding(
            padding: new EdgeInsets.all(32.0),
            child: new SizedBox(
              height: 200.0,
              child: chart,
            ),
          ),*/
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 600,
              height: 300,
              //child: Expanded(
              child:new Container(
                  child:chart

              ),
              // ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "MODAL BOTTOM SHEET EXAMPLE",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: new Icon(Icons.insert_drive_file),
                                title: new Text('Export PDF'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: new Icon(Icons.phone),
                                title: new Text('Whatapps'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: new Icon(Icons.email_outlined),
                                title: new Text('Email'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: new Icon(Icons.share),
                                title: new Text('Url'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  padding:
                  EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                  color: Colors.pink,
                  child: Text(
                    'Click Me',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

