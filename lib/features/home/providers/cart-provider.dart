import 'package:flutter/material.dart';
import 'package:proyecto_final/features/home/entities/Product.dart';

class CartProvider with ChangeNotifier {
  List<Product> _cartItems = [];

  // Obtener los productos en el carrito
  List<Product> get cartItems => _cartItems;

  // Método para agregar un producto al carrito
  void addProduct(Product product, int quantity) {
    // Verifica si el producto ya está en el carrito
    var existingProduct = _cartItems.firstWhere(
      (item) => item.id == product.id,
      orElse: () => Product(id: -1, name: '', price: 0.0, imageUrl: '', quantity: 0),
    );

    if (existingProduct.id != -1) {
      // Si el producto ya está, actualizamos la cantidad
      existingProduct.setQuantity = existingProduct.getQuantity + quantity;
    } else {
      // Si el producto no está en el carrito, lo agregamos
      product.setQuantity = quantity;
      _cartItems.add(product);
    }

    // Notificar a los escuchas que el carrito ha cambiado
    notifyListeners();
  }

  // Método para eliminar un producto del carrito
  void removeProduct(Product product) {
    _cartItems.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

   void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Método para obtener el total del carrito
  double get totalAmount {
    double total = 0;
    for (var product in _cartItems) {
      total += product.price * product.getQuantity;
    }
    return total;
  }
}
