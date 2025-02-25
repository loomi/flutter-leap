import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_leap_v2/app/modules/home_module/domain/errors/errors.dart';
import 'package:flutter_leap_v2/shared/utils/misc.dart';

import '../../../../../shared/utils/app_state.dart';
import '../../domain/usecases/intefaces/i_get_example_uc.dart';
import '../../infra/models/example_model.dart';

part 'example_store.g.dart';

@lazySingleton
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
  AsyncResultDart<ExampleModel, ExampleError> getExample() async {
    appState = AppState.loading;

    var result = await GetIt.I.get<IGetExampleUseCase>()();

    return result.fold(
      (success) {
        debugPrint("Success ${success.toJson()}");
        changeAppState(AppState.loaded);
        return Success(success);
      },
      (failure) {
        changeAppState(AppState.error);

        logException(
          "ExampleStore.getExample",
          failure.message,
          StackTrace.current.toString(),
        );

        return Failure(failure);
      },
    );
  }
}
