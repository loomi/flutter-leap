
import 'package:loomi_flutter_boilerplate/src/data/models/example.dart';

abstract class IExampleRepository{
  Future<Example> getExample();
}