/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:plastic_counter/DataPage/PieChart.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final List<LinearSales> data;

  SimpleBarChart(this.seriesList, this.animate, this.data);

  @override
  Widget build(BuildContext context) {
    double largest = -1;

    data.forEach((element) {
      if (element.grams > largest) {
        largest = element.grams;
      }
    });

    if (largest < 100) {
      largest = 100;
    } else if (largest < 200) {
      largest = 200;
    } else if (largest < 300) {
      largest = 300;
    } else if (largest < 400) {
      largest = 400;
    } else if (largest < 500) {
      largest = 500;
    } else if (largest < 600) {
      largest = 600;
    } else if (largest < 800) {
      largest = 800;
    } else if (largest < 1000) {
      largest = 1000;
    } else if (largest < 1500) {
      largest = 1500;
    } else if (largest < 2000) {
      largest = 2000;
    } else if (largest < 3000) {
      largest = 3000;
    } else if (largest < 4000) {
      largest = 4000;
    }

    final staticTicks = <charts.TickSpec<double>>[
      new charts.TickSpec(0),
      new charts.TickSpec(largest / 4),
      new charts.TickSpec(largest / 2),
      new charts.TickSpec(largest / 4 * 3),
      new charts.TickSpec(largest),
    ];

    return new Container(
        height: 300,
        margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: charts.BarChart(
          seriesList,
          animate: animate,
          domainAxis: new charts.OrdinalAxisSpec(
              renderSpec: new charts.SmallTickRendererSpec(
                  // Tick and Label styling here.
                  labelStyle: new charts.TextStyleSpec(
                      fontSize: 10, // size in Pts.
                      color: charts.MaterialPalette.white),

                  // Change the line colors to match text color.
                  lineStyle: new charts.LineStyleSpec(
                      color: charts.MaterialPalette.white))),
          primaryMeasureAxis: new charts.NumericAxisSpec(
              tickProviderSpec:
                  new charts.StaticNumericTickProviderSpec(staticTicks),
              renderSpec: new charts.GridlineRendererSpec(
                  // Tick and Label styling here.
                  labelStyle: new charts.TextStyleSpec(
                      fontSize: 10, // size in Pts.
                      color: charts.MaterialPalette.white),

                  // Change the line colors to match text color.
                  lineStyle: new charts.LineStyleSpec(
                      color: charts.MaterialPalette.white))),
        ));
  }
}
