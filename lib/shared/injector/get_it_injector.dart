import 'package:get_it/get_it.dart';

import 'i_dependency_injector.dart';

class GetItInjector implements IDependencyInjector {
  final GetIt _getIt = GetIt.instance;

  @override
  void registerSingleton<T extends Object>(T instance) {
    _getIt.registerSingleton<T>(instance);
  }

  @override
  void registerFactory<T extends Object>(T Function() factoryFunc) {
    _getIt.registerFactory<T>(factoryFunc);
  }
}
