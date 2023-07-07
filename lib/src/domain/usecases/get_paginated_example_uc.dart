import 'package:get_it/get_it.dart';
import 'package:flutter_leap/src/domain/repositories/i_pagination_example_repository.dart';
import 'package:flutter_leap/src/external/models/paginated_response.dart';
import 'package:flutter_leap/src/presentation/usecases/i_get_paginated_example_uc.dart';

class GetPaginationExampleUC implements IGetPaginationExampleUC {
  @override
  Future<PaginatedResponse?> call({required int page}) async {
    return await GetIt.I
        .get<IPaginationExampleRepository>()
        .getPaginationExample(
          page: page,
        );
  }
}
