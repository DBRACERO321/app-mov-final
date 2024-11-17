import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/features/home/entities/Product.dart';
import 'package:proyecto_final/features/home/providers/cart-provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController quantityController = TextEditingController();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 4,
      color: Colors.grey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(5.0)),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      // Mostrar un cuadro de diálogo para ingresar la cantidad
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Cantidad para ${product.name}'),
                            content: TextField(
                              controller: quantityController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: 'Ingrese la cantidad'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Convertir la cantidad ingresada a un número
                                  int quantity = int.tryParse(quantityController.text) ?? 1;
                                  // Agregar el producto al carrito
                                  Provider.of<CartProvider>(context, listen: false)
                                      .addProduct(product, quantity);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Agregar al carrito'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancelar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.lightBlue,
                      size: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
