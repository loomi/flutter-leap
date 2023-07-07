import 'package:flutter_leap/src/external/models/paginated_response.dart';

abstract class IGetPaginationExampleUC {
  Future<PaginatedResponse?> call({required int page});
}
