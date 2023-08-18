import 'package:flutter/material.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart' show L10N;

class LocalizationOverride extends StatelessWidget {
  final String languageCode;
  final Widget Function(BuildContext context) builder;

  const LocalizationOverride({
    required this.languageCode,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      locale: Locale(languageCode),
      context: context,
      child: Builder(
        builder: (context) {
          return builder(context);
        },
      ),
    );
  }
}
