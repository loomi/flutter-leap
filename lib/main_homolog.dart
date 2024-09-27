import 'package:flutter_leap_v2/bootstrap.dart';
import 'package:flutter_leap_v2/shared/utils/flavors_options.dart';

void main() async {
  bootstrap(
    flavor: FlavorsOptions.homolog,
    sentryUrlDsn: "", //const String.fromEnvironment('SENTRY_DSN')
  );
}
