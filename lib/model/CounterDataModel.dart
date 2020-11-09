import 'package:json_annotation/json_annotation.dart';

part 'CounterDataModel.g.dart';

@JsonSerializable()
class CounterDataModel {
  String title;
  String units;
  int count;
  double grams;

  CounterDataModel(String title, String units, int count) {
    this.title = title;
    this.units = units;
    this.count = count;
  }

  String toString() {
    return title + ", " + units + ", " + count.toString();
  }

  factory CounterDataModel.fromJson(Map<String, dynamic> json) =>
      _$CounterDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CounterDataModelToJson(this);
}
