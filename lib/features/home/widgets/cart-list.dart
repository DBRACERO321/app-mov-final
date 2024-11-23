import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
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

  Future<void> _generatePdfAndDownload(CartProvider cartProvider) async {
    final pdf = pw.Document();
    final cartItems = cartProvider.cartItems;

    // Cargar el logotipo desde los assets
    final logoBytes = await rootBundle.load('assets/images/logo.png');
    final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

    // Calcular subtotal, IVA y total
    final subtotal = cartProvider.totalAmount;
    final iva = subtotal * 0.15; // 15% de IVA
    final totalConIva = subtotal + iva;

    // Obtener fecha y hora actual
    final now = DateTime.now();
    final formattedDate = "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
    final formattedTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Logotipo y encabezado
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(logoImage, width: 100),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        "Factura de Compra",
                        style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        "Fecha: $formattedDate",
                        style: pw.TextStyle(fontSize: 12),
                      ),
                      pw.Text(
                        "Hora: $formattedTime",
                        style: pw.TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              // Tabla de items
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(4),
                  1: pw.FlexColumnWidth(2),
                  2: pw.FlexColumnWidth(2),
                  3: pw.FlexColumnWidth(2),
                },
                children: [
                  // Encabezados de la tabla
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text("Artículo", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text("Cantidad", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text("Precio Unit.", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text("Total", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),

                  // Filas de la tabla
                  ...cartItems.map((item) {
                    final total = item.getQuantity * item.price;
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(item.name),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(item.getQuantity.toString()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text("\$${item.price.toStringAsFixed(2)}"),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text("\$${total.toStringAsFixed(2)}"),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
              pw.SizedBox(height: 20),

              // Subtotal, IVA y Total
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    "Subtotal: \$${subtotal.toStringAsFixed(2)}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    "IVA (15%): \$${iva.toStringAsFixed(2)}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    "Total: \$${totalConIva.toStringAsFixed(2)}",
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Descargar el PDF
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'Factura.pdf');
  }


  void _showThankYouModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Gracias por su compra"),
          content: Text("Su factura ha sido generada y descargada."),
          actions: [
            TextButton(
              child: Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                Invoice(date: today, items: cartProvider.cartItems);
                await DBOShoppingCart().insertInvoice(invoiceForInsert);

                // Generar y descargar el PDF
                await _generatePdfAndDownload(cartProvider);

                // Mostrar modal de agradecimiento
                _showThankYouModal(context);

                // Limpiar el carrito después de la compra
                cartProvider.clearCart();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[50], // Fondo del botón
              ),
              child: Text(
                  "Finalizar Compra - Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}"),
            ),
          );
        },
      ),
    );
  }
}
