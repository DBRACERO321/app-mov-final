import 'package:proyecto_final/features/cart-item/entities/cart-item.entity.dart';
import 'package:proyecto_final/features/invoice/entities/invoice.entity.dart';
import 'package:proyecto_final/helpers/connection/connection.helper.dart';
import 'package:sqflite/sqflite.dart';

class DBOShoppingCart {
  static final DBOShoppingCart _instance = DBOShoppingCart._internal();
  late Database _db;

  DBOShoppingCart._internal();

  factory DBOShoppingCart() => _instance;

  Future<void> init() async {
    _db = await DBConnection().database;
  }

  Future<List<CartItem>> getCartItems() async {
    final List<Map<String, dynamic>> maps = await _db.query('invoice_items');
    return List.generate(
      maps.length,
      (i) => CartItem(
        productId: maps[i]['product_id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
      ),
    );
  }

  // Operaciones para facturas
  Future<int> insertInvoice(Invoice invoice) async {
    if (_db == null) {
      await init(); // Inicializa la base de datos si aún no está hecha
    }
    int id =
        await _db.insert('invoices', {'date': invoice.date.toIso8601String()});
    for (var item in invoice.items) {
      await _db.insert('invoice_items', {
        'invoice_id': id,
        'product_id': item.id,
        'name': item.name,
        'price': item.price,
        'quantity': item.quantity,
      });
    }
    return id;
  }
}
