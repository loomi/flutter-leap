import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/usecases/i_get_paginated_example_uc.dart';
import 'package:mobx/mobx.dart';

import '../../external/models/example.dart';
import '../../utils/misc.dart';
import '../usecases/i_get_example_uc.dart';

part 'example_store.g.dart';

class ExampleStore = _ExampleStore with _$ExampleStore;

abstract class _ExampleStore with Store {
  @observable
  Example? example;

  @observable
  bool loading = false;

  @observable
  bool loadingMore = false;

  @observable
  ObservableList<String> paginatedList = ObservableList();

  @observable
  int lastLoadedPage = 0;

  @observable
  bool hasNextPage = true;

  @observable
  Future<void> getPaginatedData({
    int page = 0,
  }) async {
    if (!loading && !loadingMore && hasNextPage) {
      try {
        if (page == 0) {
          paginatedList.clear();
          loading = true;
        } else {
          loadingMore = true;
        }

        var response = await GetIt.I.get<IGetPaginationExampleUC>()(
          page: page,
        );

        paginatedList.addAll(response?.data ?? []);

        if (response?.totalPages != null) {
          if (response!.totalPages! > lastLoadedPage + 1) {
            hasNextPage = true;
          } else {
            hasNextPage = false;
          }
        }

        lastLoadedPage = page;
      } catch (e, s) {
        printException("ExampleStore.getPaginatedData", e, s);
      } finally {
        if (page == 0) {
          loading = false;
        } else {
          loadingMore = false;
        }
      }
    }
  }

  @action
  Future<void> getExample() async {
    try {
      loading = true;
      example = await GetIt.I.get<IGetExampleUseCase>()();
    } catch (e, s) {
      printException("ExampleStore.getExample", e, s);
    } finally {
      loading = false;
    }
  }
}
