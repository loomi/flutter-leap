import 'package:get_it/get_it.dart';
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
