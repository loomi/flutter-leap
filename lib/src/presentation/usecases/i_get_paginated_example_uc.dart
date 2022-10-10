import 'package:loomi_flutter_boilerplate/src/external/models/paginated_response.dart';

abstract class IGetPaginationExampleUC {
  Future<PaginatedResponse?> call({required int page});
}
