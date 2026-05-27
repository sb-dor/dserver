import 'package:pizza_server/src/routes/auth_routes.dart';
import 'package:pizza_server/src/routes/order_routes.dart';
import 'package:pizza_server/src/routes/pizza_routes.dart';
import 'package:pizza_server/src/services/auth_service.dart';
import 'package:pizza_server/src/services/order_service.dart';
import 'package:pizza_server/src/services/pizza_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Assembles all route handlers into a single top-level router.
Router buildRouter({
  required AuthService authService,
  required PizzaService pizzaService,
  required OrderService orderService,
}) {
  final router = Router()
    // Mount sub-routers
    ..mount('/auth/', AuthRoutes(authService).router.call)
    ..mount('/pizzas/', PizzaRoutes(pizzaService).router.call)
    ..mount('/orders/', OrderRoutes(orderService).router.call)
    // Health check
    ..get('/health', (Request request) {
      return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
    });

  return router;
}
