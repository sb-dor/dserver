import 'dart:convert';
import 'package:pizza_server/src/services/pizza_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Pizza menu route handlers.
class PizzaRoutes {
  PizzaRoutes(this._pizzaService);

  final PizzaService _pizzaService;

  Router get router {
    final router = Router()..get('/', _getAll);

    return router;
  }

  /// GET /pizzas
  Future<Response> _getAll(Request request) async {
    final pizzas = _pizzaService.getAllPizzas();

    return Response.ok(
      jsonEncode(pizzas.map((p) => p.toJson()).toList()),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
