import 'package:flutter/foundation.dart';

@immutable
class ExampleEntity {
  final int? id;
  final int? userId;
  final String? title;

  const ExampleEntity({
    this.id,
    this.userId,
    this.title,
  });

  ExampleEntity copyWith({
    int? id,
    int? userId,
    String? title,
  }) {
    return ExampleEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
    );
  }
}
