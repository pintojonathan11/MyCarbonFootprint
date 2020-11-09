import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieChart(this.seriesList, this.animate);

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 200,
        margin: const EdgeInsets.only(top: 20),
        child: charts.PieChart(seriesList,
            animate: animate,
            defaultRenderer: new charts.ArcRendererConfig(
                arcWidth: 40,
                arcRendererDecorators: [
                  new charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.outside,
                      outsideLabelStyleSpec: new charts.TextStyleSpec(
                          fontSize: 12,
                          color: charts.Color.fromHex(code: "#FFFFFF"))),
                ])));
  }
}

/// Sample linear data type.
class LinearSales {
  final int ind;
  final String title;
  final double grams;

  LinearSales(this.ind, this.title, this.grams);
}
