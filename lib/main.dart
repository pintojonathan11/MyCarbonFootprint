import 'package:flutter/material.dart';
import 'package:plastic_counter/InfoPage/InfoPage.dart';
import 'package:plastic_counter/MainPage/HomeTrackPage.dart';
import 'package:plastic_counter/DataPage/MyDataPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    data.then((value) => print(value[1].units));
    return MaterialApp(
      title: 'My Carbon Footprint',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'My Carbon Footprint'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
//  MyHomePage({Key key, this.title, this.data}) : super(key: key);

  String title;
  Section section;

  @override
  void initState() {
    super.initState();
    section = Section.Track;

    title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (section) {
      case Section.Track:
        body = new HomeTrackPage();
        break;

      case Section.My_Data:
        body = new MyDataPage();
        break;
      case Section.Info:
        body = new InfoPage();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: null,
      ),
      body: body,
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
              title: Text('Welcome'),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  section = Section.Info;
                });
              },
            ),
            ListTile(
              title: Text('Track'),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  section = Section.Track;
                });
              },
            ),
            ListTile(
              title: Text('My data'),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  section = Section.My_Data;
                });
              },
            ),
          ],
        ), // Populate the Drawer in the next step.
      ),
    );
  }
}

enum Section {
  Track,
  My_Data,
  Info,
}
