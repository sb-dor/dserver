import 'dart:io';

/// Server configuration constants.
class ServerConfig {
  ServerConfig._();

  /// JWT signing secret. In production, use environment variable.
  static const String jwtSecret = 'pizzaf-super-secret-jwt-key-change-in-production';

  /// JWT access token lifetime.
  static const Duration accessTokenLifetime = Duration(hours: 1);

  /// Refresh token lifetime.
  static const Duration refreshTokenLifetime = Duration(days: 14);

  /// Server port.
  static int port = int.parse(Platform.environment['PORT'] ?? '8080');

  /// Server host.
  static const String host = '0.0.0.0';
}
