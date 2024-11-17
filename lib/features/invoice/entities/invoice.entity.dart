import 'package:proyecto_final/features/home/entities/Product.dart';

class Invoice {
  final int? id;
  final DateTime date;
  final List<Product> items;

  Invoice({this.id, required this.date, required this.items});
}