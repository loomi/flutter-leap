import 'package:flutter/foundation.dart';

@immutable
class ExampleEntity {
  final int id;
  final String name;

  const ExampleEntity({
    this.id = 0,
    this.name = '',
  });

  ExampleEntity copyWith({
    int? id,
    String? name,
  }) {
    return ExampleEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
