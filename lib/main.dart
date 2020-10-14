import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plastic_counter/model/CounterDataModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:async';
import 'package:plastic_counter/CounterStorage.dart';

List<CounterDataModel> counterData = [];
CounterStorage counterStorage = new CounterStorage();

Future loadCounterData() async {
  CounterDataModel readPlastic = await counterStorage.readPlasticBags();

  if (readPlastic == null) {
    counterData = await counterStorage.initWrite();
  } else {
    CounterDataModel readWater = await counterStorage.readWaterBottles();
    CounterDataModel readCarp = await counterStorage.readCarpooled();
    CounterDataModel readWalked = await counterStorage.readWalked();

    counterData.add(readPlastic);
    counterData.add(readWater);
    counterData.add(readCarp);
    counterData.add(readWalked);
  }

  return counterData;
}

void main() => runApp(MyApp(data: loadCounterData()));

class MyApp extends StatelessWidget {
  final Future data;

  MyApp({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'My Carbon Footprint', data: data),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title, this.data}) : super(key: key);

  final String title;
  final Future data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: null,
      ),
      body: Center(
        child: FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/recycle_city_background.jpeg"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: ListView.builder(
                  itemCount: counterData.length,
                  itemBuilder: (context, index) {
                    return TrackPage(
                      title: counterData[index].title,
                      units: counterData[index].units,
                      count: counterData[index].count,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/forrest.jpeg"),
                      fit: BoxFit.cover)),
            ),
            ListTile(
              title: Text('Track'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('My data'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Info'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ), // Populate the Drawer in the next step.
      ),
    );
  }
}

class TrackPage extends StatefulWidget {
  final String title;
  final String units;
  int count;

  TrackPage({this.title, this.units, this.count});

  @override
  _ItemCounterState createState() => _ItemCounterState();
}

class _ItemCounterState extends State<TrackPage> {
  String units = "";
  int _count;
  bool _isLarger = false;
  double _width = -1;
  double _height = -1;

  Timer timer;

  @override
  void initState() {
    super.initState();
    _count = widget.count;
    units = widget.units;
  }

  void subtract() {
    setState(() {
      if (_count > 0) {
        _count--;
        if (units == "Plastic Bags") {
          counterData[0].count -= 1;
          counterStorage.writePlasticBags(_count);
        } else if (units == "Water Bottles") {
          counterData[1].count -= 1;
          counterStorage.writeWaterBottles(_count);
        } else if (units == "Miles") {
          counterData[2].count -= 1;
          counterStorage.writeCarpooled(_count);
        } else if (units == "Minutes") {
          counterData[3].count -= 1;
          counterStorage.writeWalked(_count);
        }
      }
    });
  }

  void add() {
    setState(() {
      _count++;

      if (units == "Plastic Bags") {
        counterData[0].count += 1;
        counterStorage.writePlasticBags(_count);
      } else if (units == "Water Bottles") {
        counterData[1].count += 1;
        counterStorage.writeWaterBottles(_count);
      } else if (units == "Miles") {
        counterData[2].count += 1;
        counterStorage.writeCarpooled(_count);
      } else if (units == "Minutes") {
        counterData[3].count += 1;
        counterStorage.writeWalked(_count);
      }
    });
  }

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
          opacity: 0.7,
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
                color: const Color.fromRGBO(230, 255, 242, 1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.info),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.settings),
                        ),
                        title: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: AutoSizeText("${widget.title}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                              maxLines: 1),
                        )
//              AutoSizeText("${widget.name}",
//                  textAlign: TextAlign.center,
//                  style: TextStyle(fontSize: 30),
//                  maxLines: 2),
//              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                        ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  child: GestureDetector(
                                    child: IconButton(
                                      alignment: Alignment.center,
                                      icon: Icon(
                                        Icons.remove,
                                        color: const Color.fromRGBO(
                                            0, 128, 128, 1),
                                      ),
                                      iconSize: 80,
                                      onPressed: () {
                                        subtract();
                                      },
                                    ),
                                    onTapDown: (TapDownDetails details) {
                                      timer = Timer.periodic(
                                          Duration(milliseconds: 100), (t) {
                                        subtract();
                                      });
                                    },
                                    onTapUp: (TapUpDetails details) {
                                      timer.cancel();
                                    },
                                    onTapCancel: () {
                                      timer.cancel();
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20.0),
                                  width: 200.0,
                                  height: 200.0,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text("$_count"),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 20.0),
                                    child: GestureDetector(
                                      child: IconButton(
                                        alignment: Alignment.center,
                                        icon: Icon(
                                          Icons.add,
                                          color: const Color.fromRGBO(
                                              0, 128, 128, 1),
                                        ),
                                        iconSize: 80,
                                        onPressed: () {
                                          add();
                                        },
                                      ),
                                      onTapDown: (TapDownDetails details) {
                                        timer = Timer.periodic(
                                            Duration(milliseconds: 100), (t) {
                                          add();
                                        });
                                      },
                                      onTapUp: (TapUpDetails details) {
                                        timer.cancel();
                                      },
                                      onTapCancel: () {
                                        timer.cancel();
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: AutoSizeText("$units",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                          maxLines: 2),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}