class Environments {
  static String get baseUrl => const String.fromEnvironment('BASE_URL');

  static String get sentryUrlDsn => const String.fromEnvironment(
        'SENTRY_DSN',
      );
  static String get authenticationEncryptionKey => const String.fromEnvironment(
        'ENCRYPTION_KEY',
      ); //create your own with => secure-random -l 16

  static String get authenticationIvKey => const String.fromEnvironment(
        'IV_KEY',
      ); //create your own with => secure-random -l 16
}
