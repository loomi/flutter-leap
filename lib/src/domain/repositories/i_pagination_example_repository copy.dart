import 'package:loomi_flutter_boilerplate/src/external/models/paginated_response.dart';

abstract class IPaginationExampleRepository {
  Future<PaginatedResponse> getPaginationExample({required int page});
}
