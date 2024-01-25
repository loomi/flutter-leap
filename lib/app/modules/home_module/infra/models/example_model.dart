import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_leap_v2/app/modules/home_module/domain/entities/example_entity.dart';

part "example_model.g.dart";

@JsonSerializable()
class ExampleModel extends ExampleEntity {
  const ExampleModel({
    int id = -1,
    String name = '',
  }) : super(id: id, name: name);

  factory ExampleModel.fromJson(Map<String, dynamic> json) =>
      _$ExampleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleModelToJson(this);
}
