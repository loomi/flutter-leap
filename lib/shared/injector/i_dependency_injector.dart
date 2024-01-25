abstract class IDependencyInjector {
  void registerSingleton<T extends Object>(T instance);
  void registerFactory<T extends Object>(T Function() factoryFunc);
}
