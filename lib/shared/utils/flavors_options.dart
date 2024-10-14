enum FlavorsOptions { staging, production, homolog }

class FlavorsConfig {
  static final FlavorsConfig _instance = FlavorsConfig._internal();

  late FlavorsOptions flavor;

  factory FlavorsConfig() {
    return _instance;
  }

  FlavorsConfig._internal();

  static void initialize(FlavorsOptions flavor) {
    _instance.flavor = flavor;
  }
}
