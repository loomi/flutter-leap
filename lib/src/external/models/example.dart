import 'package:json_annotation/json_annotation.dart';

part "example.g.dart";

@JsonSerializable()
class Example {
  final int id;
  final String name;

  Example({this.id = -1, this.name = ""});

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
