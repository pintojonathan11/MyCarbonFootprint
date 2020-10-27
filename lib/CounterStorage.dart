import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:plastic_counter/model/CounterDataModel.dart';

class CounterStorage {
  Future<String> get _localPath async {
    Directory directory;
    try {
      directory = await getApplicationDocumentsDirectory();
    } catch (e) {
      directory = await getApplicationDocumentsDirectory();
    }
    return directory.path;
  }

  Future<File> get _plasticBagsFile async {
    String path = await _localPath;
    File f = File('$path/plastic_bags.txt');
    if (!(await f.exists())) {
      await f.create();
    }

    return f;
  }

  Future<File> get _waterBottlesFile async {
    final path = await _localPath;
    File f = File('$path/water_bottles.txt');

    if (!(await f.exists())) {
      await f.create();
    }

    return f;
  }

  Future<File> get _carpooledFile async {
    final path = await _localPath;
    File f = File('$path/carpooled.txt');

    if (!(await f.exists())) {
      await f.create();
    }

    return f;
  }

  Future<File> get _walkedFile async {
    final path = await _localPath;
    File f = File('$path/walked.txt');

    if (!(await f.exists())) {
      await f.create();
    }

    return f;
  }

  Future<CounterDataModel> readPlasticBags() async {
    try {
      File file = await _plasticBagsFile;

      // Read the file
      String contents = await file.readAsString();

      List<String> listOfItems = contents.split("|");

      if (listOfItems.length == 0) {
        return null;
      }

      return new CounterDataModel(
          listOfItems[0], listOfItems[1], int.parse(listOfItems[2]));
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writePlasticBagsCount(int counter) async {
    final file = await _plasticBagsFile;

    return readPlasticBags().then((value) {
      value.count = counter;
      return file.writeAsString(convertCounterDataToString(value));
    });
  }

  Future<File> writePlasticBagsUnit(String unit) async {
    final file = await _plasticBagsFile;

    return readPlasticBags().then((value) {
      value.units = unit;
      return file.writeAsString(convertCounterDataToString(value));
    });
  }

  Future<CounterDataModel> readWaterBottles() async {
    try {
      final file = await _waterBottlesFile;

      // Read the file
      String contents = await file.readAsString();

      List<String> listOfItems = contents.split("|");

      listOfItems.forEach((element) {
        print(element);
      });

      if (listOfItems.length == 0) {
        return null;
      }

      return new CounterDataModel(
          listOfItems[0], listOfItems[1], int.parse(listOfItems[2]));
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writeWaterBottlesCount(int counter) async {
    final file = await _waterBottlesFile;

    return readWaterBottles().then((value) {
      value.count = counter;
      return file.writeAsString(convertCounterDataToString(value));
    });
  }

  Future<File> writeWaterBottlesUnit(String unit) async {
    unit = "Water Bottles (" + unit + ")";

    final file = await _waterBottlesFile;

    return readWaterBottles().then((value) {
      value.units = unit;
      return file.writeAsString(convertCounterDataToString(value));
    });
  }

  Future<CounterDataModel> readCarpooled() async {
    try {
      final file = await _carpooledFile;

      // Read the file
      String contents = await file.readAsString();

      List<String> listOfItems = contents.split("|");

      if (listOfItems.length == 0) {
        return null;
      }

      return new CounterDataModel(
          listOfItems[0], listOfItems[1], int.parse(listOfItems[2]));
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writeCarpooledCount(int counter) async {
    final file = await _carpooledFile;

    return readCarpooled().then((value) {
      value.count = counter;
      return file.writeAsString(convertCounterDataToString(value));
    });
  }

  Future<File> writeCarpooledUnit(String unit) async {
    final file = await _carpooledFile;

    return readCarpooled().then((value) {
      value.units = unit;
      return file.writeAsString(convertCounterDataToString(value));
    });
  }

  Future<CounterDataModel> readWalked() async {
    try {
      final file = await _walkedFile;

      // Read the file
      String contents = await file.readAsString();

      List<String> listOfItems = contents.split("|");

      if (listOfItems.length == 0) {
        return null;
      }

      return new CounterDataModel(
          listOfItems[0], listOfItems[1], int.parse(listOfItems[2]));
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writeWalkedCount(int counter) async {
    final file = await _walkedFile;

    return readWalked().then((value) {
      value.count = counter;
      return file.writeAsString(convertCounterDataToString(value));
    });
  }

  Future<File> writeWalkedUnit(String unit) async {
    final file = await _walkedFile;

    return readWalked().then((value) {
      value.units = unit;
      return file.writeAsString(convertCounterDataToString(value));
    });
  }

  String convertCounterDataToString(CounterDataModel value) {
    return value.title + "|" + value.units + "|" + value.count.toString();
  }

  Future<List<CounterDataModel>> initWrite() async {
    final plasticFile = await _plasticBagsFile;
    final waterFile = await _waterBottlesFile;
    final carpoolFile = await _carpooledFile;
    final walkedFile = await _walkedFile;

    plasticFile.writeAsString("Avoided|Plastic Bags|0");
    waterFile.writeAsString("Refilled|Water Bottles (16.9 oz/0.5 L)|0");
    carpoolFile.writeAsString("Carpooled|Miles|0");
    walkedFile.writeAsString("Walked|Minutes|0");

    List<CounterDataModel> list = [];
    list.add(new CounterDataModel("Avoided", "Plastic Bags", 0));
    list.add(
        new CounterDataModel("Refilled", "Water Bottles (16.9 oz/0.5 L)", 0));
    list.add(new CounterDataModel("Carpooled", "Miles", 0));
    list.add(new CounterDataModel("Walked", "Minutes", 0));

    return list;
  }
}
