import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_leap_v2/app/modules/home_module/domain/entities/example_entity.dart';

part "example_model.g.dart";

@JsonSerializable()
class ExampleModel extends ExampleEntity {
  const ExampleModel({
    super.id,
    super.title,
    super.userId,
  });

  factory ExampleModel.fromJson(Map<String, dynamic> json) =>
      _$ExampleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleModelToJson(this);
}
