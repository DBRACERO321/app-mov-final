import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/features/home/app-home.dart';
import 'package:proyecto_final/features/home/providers/cart-provider.dart';
import 'package:proyecto_final/features/invoice/entities/invoice.entity.dart';
import 'package:proyecto_final/features/navigation/app-drawer.dart';
import 'package:proyecto_final/helpers/connection/connection.helper.dart';
import 'package:proyecto_final/helpers/shopping-cart/shopping-cart.helper.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  void initState() {
    super.initState();
    DBOShoppingCart()
        .init(); // Asegúrate de inicializar la base de datos antes de usarla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carrito de Compras")),
      drawer: AppDrawer(),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.cartItems;

          if (cartItems.isEmpty) {
            return Center(child: Text("El carrito está vacío"));
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];
              TextEditingController quantityController =
                  TextEditingController(text: product.getQuantity.toString());

              return Card(
                child: ListTile(
                  leading: Image.network(product.imageUrl),
                  title: Text(product.name),
                  subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (product.getQuantity > 1) {
                            cartProvider.addProduct(product, -1);
                          }
                        },
                      ),
                      Text(product.getQuantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          cartProvider.addProduct(product, 1);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cartProvider.removeProduct(product);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomSheet: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                DateTime today = DateTime.now();
                Invoice invoiceForInsert =
                    new Invoice(date: today, items: cartProvider.cartItems);
                final invoiceId =
                    await DBOShoppingCart().insertInvoice(invoiceForInsert);
                print("aqui se debe limpiar el carrito");
                 final resultados =
                    await DBOShoppingCart().getCartItems();
                    print("resultados $resultados");
                cartProvider.clearCart(); // Limpia el carrito después de la compra
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                ); // Regresa a la pantalla anterior
              },
              child: Text(
                  "Finalizar Compra - Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}"),
            ),
          );
        },
      ),
    );
  }
}
