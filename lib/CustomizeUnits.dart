import 'package:flutter/material.dart';
import 'package:plastic_counter/CounterStorage.dart';

class CustomizeUnits extends StatefulWidget {
  final String topic;
  final int ind;
  final int count;
  Function callback;
  Function loadData;

  CustomizeUnits(
      {Key key, this.topic, this.ind, this.count, this.callback, this.loadData})
      : super(key: key);

  @override
  CustomizableUnitsState createState() => CustomizableUnitsState();
}

class CustomizableUnitsState extends State<CustomizeUnits> {
  CounterStorage counterStorage = new CounterStorage();

  int ind;
  String topic;
  int count;

  String title = "Change Units";
  String currentUnit = "";
  List<String> unitList = [];

  String ogUnit = "";

  void updateUnit() async {
    if (ogUnit != currentUnit) {
      // Need to change the units now
      if (ind == 1) {
        await counterStorage.writeWaterBottlesUnit(currentUnit);
      } else if (ind == 2) {
        await counterStorage.writeCarpooledUnit(currentUnit);
      } else if (ind == 3) {
        await counterStorage.writeWalkedUnit(currentUnit);
      }

      this.widget.callback(this.widget.loadData());
    }

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    ind = widget.ind;
    topic = widget.topic;
    count = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    if (unitList.isEmpty) {
      if (ind == 1) {
        currentUnit =
            topic.substring("Water Bottles (".length, topic.length - 1);
        unitList.add("16.9 oz/0.5 L");
        unitList.add("33.8 oz/1 L");
        unitList.add("1 gal/3.79 L");
      } else if (ind == 2) {
        currentUnit = topic;
        unitList.add(("Miles"));
        unitList.add("Kilometers");
      } else if (ind == 3) {
        currentUnit = topic;
        unitList.add(("Seconds"));
        unitList.add("Minutes");
        unitList.add("Hours");
      }

      ogUnit = currentUnit;
    }

    return AlertDialog(
      title: Text(title),
      content: DropdownButton<String>(
        value: currentUnit,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        style: TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.green,
        ),
        onChanged: (String newValue) {
          setState(() {
            print(unitList);

            currentUnit = newValue;
          });
        },
        items: unitList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      actions: [
        FlatButton(
          child: Text("Done"),
          onPressed: updateUnit,
        ),
      ],
      elevation: 24.0,
    );
  }
}
