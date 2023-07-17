import 'package:flutter_leap/src/external/models/paginated_response.dart';

abstract class IPaginationExampleRepository {
  Future<PaginatedResponse> getPaginationExample({required int page});
}
