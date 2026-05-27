import 'dart:io';

/// Server configuration constants.
class ServerConfig {
  ServerConfig._();

  /// JWT signing secret.
  ///
  /// Set JWT_SECRET in production. The fallback keeps local development simple.
  static String get jwtSecret =>
      Platform.environment['JWT_SECRET'] ?? 'pizzaf-local-development-jwt-secret';

  /// JWT access token lifetime.
  static const Duration accessTokenLifetime = Duration(seconds: 20);

  /// Refresh token lifetime.
  static const Duration refreshTokenLifetime = Duration(days: 14);

  /// Server port.
  static int get port => int.tryParse(Platform.environment['PORT'] ?? '') ?? 8080;

  /// Server host.
  static const String host = '0.0.0.0';
}
