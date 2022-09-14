import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/external/models/paginated_response.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/usecases/i_get_paginated_example_uc.dart';

class GetPaginatedExampleUC implements IGetPaginatedExampleUC {
  @override
  Future<PaginatedResponse?> call({required int page}) async {
    PaginatedResponse page0 = PaginatedResponse(
      page: 0,
      data: ["1", "2", "3", "4", "5", "6", "7"],
      totalPages: 2,
    );
    PaginatedResponse page1 = PaginatedResponse(
      page: 1,
      data: ["8", "9", "10", "11", "12", "13", "14"],
      totalPages: 2,
    );
    PaginatedResponse page2 = PaginatedResponse(
      page: 2,
      data: ["15", "16", "17", "18", "19", "20", "21"],
      totalPages: 2,
    );

    await Future.delayed(
      const Duration(seconds: 2),
    );

    switch (page) {
      case 0:
        return page0;
      case 1:
        return page1;
      case 2:
        return page2;
      default:
        return null;
    }
  }
}
