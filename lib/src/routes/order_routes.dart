import 'dart:convert';
import 'dart:io';
import 'package:pizza_server/src/dto/requests.dart';
import 'package:pizza_server/src/middleware/auth_middleware.dart';
import 'package:pizza_server/src/services/order_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Order management route handlers.
class OrderRoutes {
  OrderRoutes(this._orderService);

  final OrderService _orderService;

  Router get router {
    final router = Router()
      ..post('/', _create)
      ..get('/', _getAll)
      ..get('/<id>', _getById);

    return router;
  }

  /// POST /orders — Place a new order
  Future<Response> _create(Request request) async {
    try {
      final userId = getUserId(request);
      final body = await request.readAsString();
      final json = jsonDecode(body) as Map<String, Object?>;
      final req = CreateOrderRequest.fromJson(json);

      final order = _orderService.placeOrder(userId, req);

      return Response(
        HttpStatus.created,
        body: jsonEncode(order.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
    } on OrderException catch (e) {
      return Response(
        HttpStatus.badRequest,
        body: jsonEncode({'error': e.message}),
        headers: {'Content-Type': 'application/json'},
      );
    } on FormatException {
      return Response(
        HttpStatus.badRequest,
        body: jsonEncode({'error': 'Invalid request body'}),
        headers: {'Content-Type': 'application/json'},
      );
    }
  }

  /// GET /orders — Get all orders for the authenticated user
  Future<Response> _getAll(Request request) async {
    final userId = getUserId(request);
    final orders = _orderService.getOrdersForUser(userId);

    return Response.ok(
      jsonEncode(orders.map((o) => o.toJson()).toList()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  /// GET `/orders/<id>` - Get a specific order.
  Future<Response> _getById(Request request, String id) async {
    final userId = getUserId(request);
    final order = _orderService.getOrder(id);

    if (order == null || order.userId != userId) {
      return Response(
        HttpStatus.notFound,
        body: jsonEncode({'error': 'Order not found'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    return Response.ok(jsonEncode(order.toJson()), headers: {'Content-Type': 'application/json'});
  }
}
