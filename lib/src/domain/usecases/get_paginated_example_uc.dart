import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/domain/repositories/i_pagination_example_repository%20copy.dart';
import 'package:loomi_flutter_boilerplate/src/external/models/paginated_response.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/usecases/i_get_paginated_example_uc.dart';

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
