import 'package:json_annotation/json_annotation.dart';

part 'CounterDataModel.g.dart';

@JsonSerializable()
class CounterDataModel {
  String title;
  String units;
  int count;

  CounterDataModel(String title, String units, int count) {
    this.title = title;
    this.units = units;
    this.count = count;
  }

  factory CounterDataModel.fromJson(Map<String, dynamic> json) =>
      _$CounterDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CounterDataModelToJson(this);
}