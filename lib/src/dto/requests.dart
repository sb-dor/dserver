/// DTO for login requests.
class LoginRequest {
  const LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, Object?> json) =>
      LoginRequest(email: json['email'] as String, password: json['password'] as String);
  final String email;
  final String password;

  Map<String, Object?> toJson() => {'email': email, 'password': password};
}

/// DTO for register requests.
class RegisterRequest {
  const RegisterRequest({required this.name, required this.email, required this.password});

  factory RegisterRequest.fromJson(Map<String, Object?> json) => RegisterRequest(
    name: json['name'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
  );
  final String name;
  final String email;
  final String password;

  Map<String, Object?> toJson() => {'name': name, 'email': email, 'password': password};
}

/// DTO for creating a new order.
class CreateOrderRequest {
  const CreateOrderRequest({required this.items});

  factory CreateOrderRequest.fromJson(Map<String, Object?> json) => CreateOrderRequest(
    items: (json['items'] as List)
        .map((e) => CreateOrderItem.fromJson(e as Map<String, Object?>))
        .toList(),
  );
  final List<CreateOrderItem> items;

  Map<String, Object?> toJson() => {'items': items.map((e) => e.toJson()).toList()};
}

/// A single pizza item in a create order request.
class CreateOrderItem {
  const CreateOrderItem({required this.leftHalfType, required this.rightHalfType});

  factory CreateOrderItem.fromJson(Map<String, Object?> json) => CreateOrderItem(
    leftHalfType: json['leftHalfType'] as String,
    rightHalfType: json['rightHalfType'] as String,
  );
  final String leftHalfType;
  final String rightHalfType;

  Map<String, Object?> toJson() => {'leftHalfType': leftHalfType, 'rightHalfType': rightHalfType};
}
