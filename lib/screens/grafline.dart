import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;




class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});





  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
     //animate: true,
    );
  }






  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: true,
      defaultRenderer:
      charts.LineRendererConfig(
        // Dot size
        radiusPx: 5.0,
        stacked: true,
        // line width
        strokeWidthPx: 2.0,
        // Whether to display the line
        includeLine: true,
        // Whether to display dots
        includePoints: true,
        // Whether to display the included area
        includeArea: true,
        // Area color transparency 0.0-1.0
        areaOpacity: 0.2 ,
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
      ],
      selectionModels: [
        new charts.SelectionModelConfig(
            changedListener: ( model) {
              print("xxxxxxxxxxxxxxxxxxxxxx");
              print( model.selectedSeries[0].measureFn(model.selectedDatum[0].index));
              print( model.selectedSeries[0].domainFn(model.selectedDatum[0].index));

              print("xxxxxxxxxxxxxxxxxxxx");
            }
        )
      ],

    );
  }




  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 1), 50),
      new TimeSeriesSales(new DateTime(2017, 9, 2), 25),
      new TimeSeriesSales(new DateTime(2017, 9, 3), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 4), 15),
      new TimeSeriesSales(new DateTime(2017, 9, 5), 25),
      new TimeSeriesSales(new DateTime(2017, 9, 6), 7),
      new TimeSeriesSales(new DateTime(2017, 9, 7), 6),
      new TimeSeriesSales(new DateTime(2017, 9, 8), 9),
      new TimeSeriesSales(new DateTime(2017, 9, 9), 19),
      new TimeSeriesSales(new DateTime(2017, 9, 10), 9),
      new TimeSeriesSales(new DateTime(2017, 9, 11), 8),
      new TimeSeriesSales(new DateTime(2017, 9, 12), 7),
      new TimeSeriesSales(new DateTime(2017, 9, 13), 8),
      new TimeSeriesSales(new DateTime(2017, 9, 14), 4),
      new TimeSeriesSales(new DateTime(2017, 9, 15), 19),
      new TimeSeriesSales(new DateTime(2017, 9, 16), 4),
      new TimeSeriesSales(new DateTime(2017, 9, 17), 11),
      new TimeSeriesSales(new DateTime(2017, 9, 18), 8),
      new TimeSeriesSales(new DateTime(2017, 9, 19), 8),
      new TimeSeriesSales(new DateTime(2017, 9, 20), 4),
      new TimeSeriesSales(new DateTime(2017, 9, 21), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 22), 6),
      new TimeSeriesSales(new DateTime(2017, 9, 23), 10),
      new TimeSeriesSales(new DateTime(2017, 9, 24), 15),
      new TimeSeriesSales(new DateTime(2017, 9, 25), 20),

    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        //dashPatternFn: (_, __) => [8, 2, 4, 2],
        data: data,

      ),

    ];
  }


}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}


