import 'package:flutter_leap_v2/bootstrap.dart';
import 'package:flutter_leap_v2/shared/utils/setups/setup_flavors.dart';

void main() async {
  bootstrap(
    flavor: FlavorsOptions.production,
    sentryUrlDsn: "", //const String.fromEnvironment('SENTRY_DSN')
  );
}
