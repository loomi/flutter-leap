import 'package:json_annotation/json_annotation.dart';

part "paginated_response.g.dart";

@JsonSerializable()
class PaginatedResponse {
  final int page;
  final int? totalPages;
  final List<String> data;

  PaginatedResponse({
    required this.page,
    required this.data,
    this.totalPages,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedResponseToJson(this);
}
