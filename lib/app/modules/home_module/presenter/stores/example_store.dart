import 'package:flutter/material.dart';
import 'package:flutter_leap_v2/shared/utils/helpers/result_handler.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../shared/utils/app_state.dart';
import '../../../../../shared/utils/misc.dart';
import '../../domain/usecases/intefaces/i_get_example_uc.dart';
import '../../infra/models/example_model.dart';

part 'example_store.g.dart';

class ExampleStore = _ExampleStore with _$ExampleStore;

abstract class _ExampleStore with Store {
  @observable
  ExampleModel? example;

  @observable
  AppState appState = AppState.loaded;

  @action
  void changeAppState(AppState state) {
    appState = state;
  }

  @action
  Future<void> getExample() async {
    appState = AppState.loading;

    var result = await handleResult(() async {
      return await GetIt.I.get<IGetExampleUseCase>()();
    });

    if (result.isSuccess) {
      debugPrint("Success");
    } else if (result.isFailure) {
      changeAppState(AppState.error);
      logException(
        "ExampleStore.getExample",
        result.error,
        StackTrace.current.toString(),
      );
    }

    changeAppState(AppState.loaded);
  }

  @action
  Future<void> getOtherExample() async {
    appState = AppState.loading;

    await handleResultWithCallback(
      action: () async {
        return await GetIt.I.get<IGetExampleUseCase>()();
      },
      onSuccess: (data) => debugPrint("Success"),
      onError: (error, stackTrace) {
        changeAppState(AppState.error);
        logException("ExampleStore.getOtherExample", error, stackTrace);
      },
      onComplete: () => changeAppState(AppState.loaded),
    );
  }
}
