import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/usecases/i_get_paginated_example_uc.dart';
import 'package:loomi_flutter_boilerplate/src/utils/app_state.dart';
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
  AppState appState = AppState.success;

  @observable
  ObservableList<String> paginatedList = ObservableList();

  @observable
  int lastLoadedPage = 0;

  @observable
  bool hasNextPage = true;

  @action
  void changeAppState(AppState state) {
    appState = state;
  }

  @observable
  Future<void> getPaginatedData({
    int page = 0,
  }) async {
    if (appState != AppState.loading &&
        appState != AppState.loadingMore &&
        hasNextPage) {
      try {
        if (page == 0) {
          paginatedList.clear();
          changeAppState(AppState.loading);
        } else {
          changeAppState(AppState.loadingMore);
        }

        var response = await GetIt.I.get<IGetPaginationExampleUC>()(
          page: page,
        );

        paginatedList.addAll(response?.data ?? []);

        if (response?.totalPages != null) {
          if (response!.totalPages! > lastLoadedPage) {
            hasNextPage = true;
          } else {
            hasNextPage = false;
          }
        }

        lastLoadedPage = page;
      } catch (e, s) {
        printException("ExampleStore.getPaginatedData", e, s);
      } finally {
        changeAppState(AppState.success);
      }
    }
  }

  @action
  Future<void> getExample() async {
    try {
      appState = AppState.loading;
      example = await GetIt.I.get<IGetExampleUseCase>()();
    } catch (e, s) {
      changeAppState(AppState.error);
      printException("ExampleStore.getExample", e, s);
    } finally {
      changeAppState(AppState.loaded);
    }
  }
}
