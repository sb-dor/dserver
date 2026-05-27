import 'package:pizza_server/src/db/database.dart';
import 'package:pizza_server/src/dto/requests.dart';
import 'package:pizza_server/src/models/order.dart';
import 'package:uuid/uuid.dart';

/// Service for order management.
class OrderService {
  OrderService(this._db);
  final Database _db;
  final _uuid = const Uuid();

  /// Place a new order for a user.
  Order placeOrder(String userId, CreateOrderRequest request) {
    if (request.items.isEmpty) {
      throw const OrderException('Order must contain at least one item');
    }

    // Build order items and calculate total price
    final items = <OrderPizzaItem>[];
    double totalPrice = 0;

    for (final item in request.items) {
      final leftPizza = _db.getPizzaType(item.leftHalfType);
      final rightPizza = _db.getPizzaType(item.rightHalfType);

      if (leftPizza == null) {
        throw OrderException('Unknown pizza type: ${item.leftHalfType}');
      }
      if (rightPizza == null) {
        throw OrderException('Unknown pizza type: ${item.rightHalfType}');
      }

      final itemPrice = leftPizza.halfPrice + rightPizza.halfPrice;
      totalPrice += itemPrice;

      items.add(
        OrderPizzaItem(
          leftHalfType: item.leftHalfType,
          rightHalfType: item.rightHalfType,
          price: itemPrice,
        ),
      );
    }

    final order = Order(
      id: _uuid.v4(),
      userId: userId,
      items: items,
      status: OrderStatus.placed,
      createdAt: DateTime.now(),
      totalPrice: totalPrice,
    );

    _db.addOrder(order);

    // Simulate order progression in background
    _simulateOrderProgress(order.id);

    return order;
  }

  /// Get a specific order.
  Order? getOrder(String id) => _db.getOrder(id);

  /// Get all orders for a user.
  List<Order> getOrdersForUser(String userId) => _db.getOrdersForUser(userId);

  /// Simulate order status progression for demo purposes.
  /// Each status change happens after a delay.
  void _simulateOrderProgress(String orderId) {
    const statusProgression = [
      (Duration(seconds: 10), OrderStatus.preparing),
      (Duration(seconds: 25), OrderStatus.baking),
      (Duration(seconds: 45), OrderStatus.ready),
      (Duration(seconds: 60), OrderStatus.delivered),
    ];

    for (final (delay, status) in statusProgression) {
      Future.delayed(delay, () {
        _db.updateOrderStatus(orderId, status);
      });
    }
  }
}

/// Custom exception for order errors.
class OrderException implements Exception {
  const OrderException(this.message);
  final String message;

  @override
  String toString() => 'OrderException: $message';
}
