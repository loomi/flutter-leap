import 'package:dio/dio.dart';
import 'package:loomi_flutter_boilerplate/src/domain/repositories/i_pagination_example_repository%20copy.dart';
import 'package:loomi_flutter_boilerplate/src/external/models/paginated_response.dart';

class PaginationExampleDatasource implements IPaginationExampleRepository {
  PaginationExampleDatasource(Dio dio, {String baseUrl = ""});
  @override
  Future<PaginatedResponse> getPaginationExample({
    required int page,
  }) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    switch (page) {
      case 1:
        return PaginatedResponse(
          page: 1,
          data: ["8", "9", "10", "11", "12", "13", "14"],
          totalPages: 3,
        );
      case 2:
        return PaginatedResponse(
          page: 2,
          data: ["15", "16", "17", "18", "19", "20", "21"],
          totalPages: 3,
        );
      default:
        return PaginatedResponse(
          page: 0,
          data: ["1", "2", "3", "4", "5", "6", "7"],
          totalPages: 3,
        );
    }
  }
}
