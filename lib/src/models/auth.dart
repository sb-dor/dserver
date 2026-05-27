import 'package:pizza_server/src/models/user.dart';

/// Token pair returned from login and refresh endpoints.
class AuthTokens {
  const AuthTokens({required this.accessToken, required this.refreshToken});

  factory AuthTokens.fromJson(Map<String, Object?> json) => AuthTokens(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );

  final String accessToken;
  final String refreshToken;

  Map<String, Object?> toJson() => {'accessToken': accessToken, 'refreshToken': refreshToken};
}

/// Response from login/register containing user info + tokens.
class AuthResponse {
  const AuthResponse({required this.user, required this.tokens});

  factory AuthResponse.fromJson(Map<String, Object?> json) => AuthResponse(
    user: User.fromJson(json['user'] as Map<String, Object?>),
    tokens: AuthTokens.fromJson(json['tokens'] as Map<String, Object?>),
  );
  final User user;
  final AuthTokens tokens;

  Map<String, Object?> toJson() => {'user': user.toJson(), 'tokens': tokens.toJson()};
}
