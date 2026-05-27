import 'package:pizza_server/src/db/database.dart';
import 'package:pizza_server/src/models/pizza.dart';

/// Service for pizza menu operations.
class PizzaService {
  PizzaService(this._db);
  final Database _db;

  /// Get all available pizza types.
  List<PizzaInfo> getAllPizzas() => _db.getAllPizzaTypes();

  /// Get a specific pizza type by ID.
  PizzaInfo? getPizza(String id) => _db.getPizzaType(id);
}
