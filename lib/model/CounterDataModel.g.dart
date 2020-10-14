// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CounterDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounterDataModel _$CounterDataModelFromJson(Map<String, dynamic> json) {
  return CounterDataModel(
    json['title'] as String,
    json['units'] as String,
    json['count'] as int,
  );
}

Map<String, dynamic> _$CounterDataModelToJson(CounterDataModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'units': instance.units,
      'count': instance.count,
    };
