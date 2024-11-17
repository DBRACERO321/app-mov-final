import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/features/app/app.dart';
import 'package:proyecto_final/features/home/providers/cart-provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicialización de Firebase para autenticación
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), // Proveedor para el carrito
      ],
      child: App(), // Tu aplicación principal
    ),
  );
}