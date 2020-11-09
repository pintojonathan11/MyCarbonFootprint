import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:plastic_counter/DataPage/BarGraph.dart';
import 'package:plastic_counter/CounterStorage.dart';
import 'package:plastic_counter/MainPage/InfoAlertDialog.dart';
import 'package:plastic_counter/DataPage/PieChart.dart';
import 'package:plastic_counter/model/CounterDataModel.dart';

List<CounterDataModel> counterData = [];
double totalGrams = 0;
CounterStorage counterStorage = new CounterStorage();

Future loadCounterData() async {
  CounterDataModel readPlastic = await counterStorage.readPlasticBags();

  if (readPlastic == null) {
    counterData = await counterStorage.initWrite();
  } else {
    counterData = [];

    CounterDataModel readWater = await counterStorage.readWaterBottles();
    CounterDataModel readCarp = await counterStorage.readCarpooled();
    CounterDataModel readWalked = await counterStorage.readWalked();

    readPlastic.grams = 28.9 * readPlastic.count;

    if (readWater.units.indexOf("16.9") != -1) {
      readWater.grams = 82.8 * readWater.count;
    } else if (readWater.units.indexOf("33.8") != -1) {
      readWater.grams = 165.6 * readWater.count;
    } else {
      readWater.grams = 627.624 * readWater.count;
    }

    if (readCarp.units.indexOf("Miles") != -1) {
      readCarp.grams = 404.0 * readCarp.count;
    } else {
      readCarp.grams = 251.03 * readCarp.count;
    }

    if (readWalked.units.indexOf("Sec") != -1) {
      readWalked.grams = 0.45 * readWalked.count;
    } else if (readWalked.units.indexOf("Min") != -1) {
      readWalked.grams = 27.0 * readWalked.count;
    } else {
      readWalked.grams = 1620.0 * readWalked.count;
    }

    totalGrams = double.parse((readPlastic.grams +
            readWater.grams +
            readCarp.grams +
            readWalked.grams)
        .toStringAsFixed(2));

    counterData.add(readPlastic);
    counterData.add(readWater);
    counterData.add(readCarp);
    counterData.add(readWalked);
  }

  return counterData;
}

class MyDataPage extends StatefulWidget {
  MyDataPage({Key key}) : super(key: key);

  @override
  MyDataPageState createState() => MyDataPageState();
}

class MyDataPageState extends State<MyDataPage> {
  Future data;

  @override
  void initState() {
    super.initState();
    data = loadCounterData();
  }

  void callback(Future data) {
    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //(snapshot.hasData) {
            return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/tree_for_data.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: DataPage());
          }
          // By default, show a loading spinner
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class DataPage extends StatelessWidget {
  DataPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TotalCarbon(),
        CarbonInTrees(),
        CarbonTotalPieChart(),
        CarbonCompareTreeBarGraph()
      ],
    );
  }
}

class TotalCarbon extends StatefulWidget {
  TotalCarbon({Key key}) : super(key: key);

  @override
  TotalCarbonState createState() => TotalCarbonState();
}

class TotalCarbonState extends State<TotalCarbon> {
  String units = "";
  String totalAmount = "";

  @override
  void initState() {
    super.initState();
    if (totalGrams > 1000) {
      units = "kilograms";
      totalAmount = (totalGrams / 1000).toStringAsFixed(2);
    } else {
      units = "grams";
      totalAmount = totalGrams.toStringAsFixed(2);
    }
  }

  bool _isLarger = false;
  double _width = -1;
  double _height = -1;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (_width == -1) {
        _width = MediaQuery.of(context).size.width * 0.9;
        _height = MediaQuery.of(context).size.height * 0.42;
      }
    });

    return Center(
      child: Opacity(
          opacity: 0.88,
          child: AnimatedContainer(
            width: _width,
            height: _height,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: GestureDetector(
              onTap: () => setState(() {
                if (_isLarger) {
                  _width *= (1 / 1.1);
                  _height *= (1 / 1.1);
                } else {
                  _width *= 1.1;
                  _height *= 1.1;
                }
                _isLarger = !_isLarger;
              }),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                margin: const EdgeInsets.only(
                    top: 20, left: 30, right: 30, bottom: 20),
                color: const Color.fromRGBO(0, 10, 0, 1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: AutoSizeText("Total Carbon Saved",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30, color: Colors.white),
                            maxLines: 1),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, left: 40, right: 40.0),
                                  width: 150.0,
                                  height: 120.0,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: AutoSizeText(
                                      totalAmount,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: AutoSizeText(units,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                          maxLines: 1),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class CarbonInTrees extends StatefulWidget {
  CarbonInTrees({Key key}) : super(key: key);

  @override
  CarbonInTreesState createState() => CarbonInTreesState();
}

class CarbonInTreesState extends State<CarbonInTrees> {
  int numSaplingTrees = 0;
  double saplingPercent = 0;

  int numTenYearOldTrees = 0;
  double tenYearPercent = 0;

  int numAcreTrees = 0;
  double acrePercent = 0;

  double _width;
  double _height;

  @override
  void initState() {
    super.initState();
    double tempTotalGrams = totalGrams;
    if (tempTotalGrams >= 25000000) {
      numAcreTrees += tempTotalGrams ~/ 25000000.0;
      tempTotalGrams = tempTotalGrams % 25000000.0;
    } else if (tempTotalGrams >= 12500000) {
      acrePercent = 0.5;
      tempTotalGrams = tempTotalGrams - 12500000.0;
    }
    if (tempTotalGrams >= 22000) {
      numTenYearOldTrees += tempTotalGrams ~/ 22000.0;
      tempTotalGrams = tempTotalGrams % 22000.0;
    } else if (tempTotalGrams >= 11000) {
      tenYearPercent = 0.5;
      tempTotalGrams = tempTotalGrams - 11000.0;
    }
    if (tempTotalGrams >= 5900) {
      numSaplingTrees += tempTotalGrams ~/ 5900.0;
      tempTotalGrams = tempTotalGrams % 5900.0;
    }
    saplingPercent = getPercent(tempTotalGrams / 5900.0);
  }

  double getPercent(double percent) {
    if (percent < 0.5) {
      return 0;
    }
//    if (percent < 0.3) {
//      return 0.25;
//    }
    if (percent >= 0.5 && percent < 1) {
      return 0.5;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    int totalTrees = numSaplingTrees + numTenYearOldTrees + numAcreTrees;
    totalTrees += acrePercent >= 0.5 ? 1 : 0;
    totalTrees += tenYearPercent >= 0.5 ? 1 : 0;
    totalTrees += saplingPercent >= 0.5 ? 1 : 0;

    _width = MediaQuery.of(context).size.width;
    _height = (MediaQuery.of(context).size.height * 0.15) +
        (MediaQuery.of(context).size.height * 0.06 * (totalTrees) / 7);

    return Center(
      child: Opacity(
        opacity: 0.88,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          margin:
              const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
          color: const Color.fromRGBO(0, 10, 0, 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.info),
                  color: Colors.white,
                  iconSize: 20,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => InfoAlertDialog(topic: "", ind: 4),
                  ),
                ),
                trailing: IconButton(
                  iconSize: 0,
                  icon: Icon(Icons.add),
                ),
                title: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: AutoSizeText("Total Trees Saved",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                          maxLines: 1),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 20, right: 10, bottom: 20),
                alignment: Alignment.topLeft,
                child: Wrap(
                  runSpacing: 10,
                  children: [
                    for (var i = 0; i < numAcreTrees; i++)
                      CarbonTreesImage(
                          imagePath: 'assets/images/acre.png', percentage: 1),
                    for (var i = 0; i < numTenYearOldTrees; i++)
                      CarbonTreesImage(
                          imagePath: 'assets/images/young_tree.png',
                          percentage: 1),
                    for (var i = 0; i < numSaplingTrees; i++)
                      CarbonTreesImage(
                          imagePath: 'assets/images/sapling.png',
                          percentage: 1),
                    if (acrePercent != 0)
                      CarbonTreesImage(
                        imagePath: 'assets/images/acre.png',
                        percentage: acrePercent,
                      ),
                    if (tenYearPercent != 0)
                      CarbonTreesImage(
                        imagePath: 'assets/images/young_tree.png',
                        percentage: tenYearPercent,
                      ),
                    if (saplingPercent != 0)
                      CarbonTreesImage(
                        imagePath: 'assets/images/sapling.png',
                        percentage: saplingPercent,
                      ),
                    if (numSaplingTrees == 0 &&
                        numTenYearOldTrees == 0 &&
                        numAcreTrees == 0 &&
                        saplingPercent == 0)
                      AutoSizeText(
                        "Less Carbon than 50% of a young tree",
                        maxLines: 1,
                        style: TextStyle(color: Colors.white),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CarbonTreesImage extends StatelessWidget {
  final String imagePath;
  final double percentage;

  CarbonTreesImage({Key key, this.imagePath, this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Colors.black.withOpacity(1),
            Colors.black.withOpacity(1),
            Colors.black.withOpacity(0),
            Colors.black.withOpacity(0), // <-- change this opacity
            // Colors.transparent // <-- you might need this if you want full transparency at the edge
          ],
          stops: [
            0.0,
            percentage, // value to change
            0,
            1.0
          ], //<-- the gradient is interpolated, and these are where the colors above go into effect (that's why there are two colors repeated)
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        child: Image.asset(imagePath),
        height: 40,
        width: 40,
      ),
    );
  }
}

class CarbonTotalPieChart extends StatefulWidget {
  CarbonTotalPieChart({Key key}) : super(key: key);

  @override
  CarbonTotalPieChartState createState() => CarbonTotalPieChartState();
}

class CarbonTotalPieChartState extends State<CarbonTotalPieChart> {
  List<charts.Series<LinearSales, int>> seriesList;
  bool noDataRecord;

  final data = [
    new LinearSales(0, "Plastic Bags", counterData[0].grams.toDouble()),
    new LinearSales(1, "Water Bottles", counterData[1].grams.toDouble()),
    new LinearSales(2, "Carpooled", counterData[2].grams.toDouble()),
    new LinearSales(3, "Walked", counterData[3].grams.toDouble()),
  ];

  List<charts.Color> listOfColors;
  List<Color> myColors = [];

  List<charts.Series<LinearSales, int>> createData() {
    if (counterData[0].grams == 0 &&
        counterData[1].grams == 0 &&
        counterData[2].grams == 0 &&
        counterData[3].grams == 0) {
      noDataRecord = true;
      return null;
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Total Carbon',
        domainFn: (LinearSales sales, _) => sales.ind,
        measureFn: (LinearSales sales, _) => sales.grams,
        colorFn: (_, index) {
          return listOfColors[index];
        },
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) =>
//            "${row.title}: " +
            "${row.ind + 1}: " +
            (row.grams > 1000
                ? (row.grams / 1000).toStringAsFixed(2) + " kg"
                : ((row.grams).toStringAsFixed(2) + " g")),
      )
    ];
  }

  @override
  void initState() {
    super.initState();

    noDataRecord = false;

    listOfColors = charts.MaterialPalette.green.makeShades(4);

    seriesList = createData();
  }

  @override
  Widget build(BuildContext context) {
    listOfColors.forEach((element) {
      print(element);
      print("actual: " +
          int.parse("FF" + element.hexString.substring(1), radix: 16)
              .toString());
      if (myColors.length < 4) {
        myColors.add(new Color(
            int.parse("FF" + element.hexString.substring(1), radix: 16)));
      }
    });

    return Center(
      child: Opacity(
        opacity: 0.88,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          margin:
              const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
          color: const Color.fromRGBO(0, 10, 0, 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: AutoSizeText("Carbon Saved Distribution",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                          maxLines: 1),
                    )),
              ),
              if (!noDataRecord) PieChart(seriesList, true),
              if (!noDataRecord)
                Container(
                  margin: const EdgeInsets.only(
                      top: 20, bottom: 30, left: 15, right: 15),
                  child: Wrap(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Wrap(
                            children: [
                              Container(
                                height: 15.0,
                                width: 15.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: myColors[0],
                                ),
                                margin: const EdgeInsets.only(top: 10),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text("  1: " + data[0].title + "  ",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white)),
                              )
                            ],
                          ),
                          Wrap(
                            children: [
                              Container(
                                height: 15.0,
                                width: 15.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: myColors[1],
                                ),
                                margin: const EdgeInsets.only(top: 10),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text("  2: " + data[1].title + "  ",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white)),
                              )
                            ],
                          ),
                          Wrap(
                            children: [
                              Container(
                                height: 15.0,
                                width: 15.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: myColors[2],
                                ),
                                margin: const EdgeInsets.only(top: 10),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text("  3: " + data[2].title + "  ",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white)),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              Container(
                                height: 15.0,
                                width: 15.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: myColors[3],
                                ),
                                margin: const EdgeInsets.only(top: 10),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text("  4: " + data[3].title + "  ",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white)),
                              )
                            ],
                          ),
                        ],
//                        color: Color(4283215696),
                      )
                    ],
                  ),
                ),
              if (noDataRecord)
                Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 30),
                    child: AutoSizeText("No Data Is Recorded Yet",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        maxLines: 2)),
            ],
          ),
        ),
      ),
    );
  }
}

class CarbonCompareTreeBarGraph extends StatefulWidget {
  CarbonCompareTreeBarGraph({Key key}) : super(key: key);

  @override
  CarbonCompareTreeBarGraphState createState() =>
      CarbonCompareTreeBarGraphState();
}

class CarbonCompareTreeBarGraphState extends State<CarbonCompareTreeBarGraph> {
  List<charts.Series<LinearSales, String>> seriesList;
  bool noDataRecord;

  final List<LinearSales> data = [
    new LinearSales(0, "My Carbon\nContribution", totalGrams / 1000.0),
    new LinearSales(1, "Young Tree\nContribution\n(1 Year)", 5.9),
    new LinearSales(2, "Mature Tree\nContribution\n(1 Year)", 22),
    (totalGrams / 1000.0 < 100
        ? new LinearSales(3, "Acre of Trees\nContribution\n(1 Week)", 48.1)
        : new LinearSales(3, "Acre of Trees\nContribution\n(1 Month)", 208.3)),
  ];

  List<charts.Color> listOfColors;
  List<Color> myColors = [];

  List<charts.Series<LinearSales, String>> createData() {
    if (counterData[0].grams == 0 &&
        counterData[1].grams == 0 &&
        counterData[2].grams == 0 &&
        counterData[3].grams == 0) {
      noDataRecord = true;
      return null;
    }

    return [
      new charts.Series<LinearSales, String>(
        id: 'CarbonTreesBarGraph',
        domainFn: (LinearSales sales, _) => sales.title,
        measureFn: (LinearSales sales, _) => sales.grams,
        colorFn: (_, index) {
          return listOfColors[index];
        },
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) =>
//            "${row.title}: " +
            "${row.ind + 1}: " +
            (row.grams > 1000
                ? (row.grams / 1000).toStringAsFixed(2) + " kg"
                : ((row.grams).toStringAsFixed(2) + " g")),
      )
    ];
  }

  @override
  void initState() {
    super.initState();

    noDataRecord = false;

    listOfColors = charts.MaterialPalette.green.makeShades(4);

    seriesList = createData();
  }

  @override
  Widget build(BuildContext context) {
    listOfColors.forEach((element) {
      print(element);
      print("actual: " +
          int.parse("FF" + element.hexString.substring(1), radix: 16)
              .toString());
      if (myColors.length < 4) {
        myColors.add(new Color(
            int.parse("FF" + element.hexString.substring(1), radix: 16)));
      }
    });

    return Center(
      child: Opacity(
        opacity: 0.88,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          margin:
              const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
          color: const Color.fromRGBO(0, 10, 0, 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: AutoSizeText("My Carbon Contribution",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                          maxLines: 1),
                    )),
              ),
              if (!noDataRecord) SimpleBarChart(seriesList, true, data),
              if (!noDataRecord)
                Container(
                    margin: const EdgeInsets.only(
                        top: 20, bottom: 30, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Container(
                              height: 15.0,
                              width: 15.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: myColors[0],
                              ),
                              margin: const EdgeInsets.only(top: 10),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 13),
                              child: Text(
                                  "  1: " +
                                      data[0].title.replaceAll("\n", " ") +
                                      "  ",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)),
                            )
                          ],
                        ),
                        Wrap(
                          children: [
                            Container(
                              height: 15.0,
                              width: 15.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: myColors[1],
                              ),
                              margin: const EdgeInsets.only(top: 10),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 13),
                              child: Text(
                                  "  2: " +
                                      data[1].title.replaceAll("\n", " ") +
                                      "  ",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)),
                            )
                          ],
                        ),
                        Wrap(
                          children: [
                            Container(
                              height: 15.0,
                              width: 15.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: myColors[2],
                              ),
                              margin: const EdgeInsets.only(top: 10),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 13),
                              child: Text(
                                  "  3: " +
                                      data[2].title.replaceAll("\n", " ") +
                                      "  ",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Container(
                              height: 15.0,
                              width: 15.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: myColors[3],
                              ),
                              margin: const EdgeInsets.only(top: 10),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 13),
                              child: Text(
                                  "  4: " +
                                      data[3].title.replaceAll("\n", " ") +
                                      "  ",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)),
                            )
                          ],
                        ),
                      ],
                    )),
              if (noDataRecord)
                Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 30),
                    child: AutoSizeText("No Data Is Recorded Yet",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        maxLines: 2)),
            ],
          ),
        ),
      ),
    );
  }
}
