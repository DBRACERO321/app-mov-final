import 'package:flutter/material.dart';
import 'package:proyecto_final/common-widgets/appbar/entities/appbar.dart';

class AppbarW extends StatelessWidget implements PreferredSizeWidget {
  final Appbar appbar;

  const AppbarW({Key? key, required this.appbar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appbar.title, // Usar el título dinámico del objeto Appbar
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.lightBlue),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
    );
  }

  // Definir el tamaño preferido para cumplir con PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
