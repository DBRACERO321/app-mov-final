import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/navigation/app-drawer.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<DrawerCubit>(context), // Reutiliza el estado del Drawer.
      child: Scaffold(
         appBar: AppBar(
          title: const Text('Settings',style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blueGrey),),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.lightBlue),
                onPressed: () {
                  Scaffold.of(context)
                      .openDrawer(); // Usa el contexto correcto aquí
                },
              );
            },
          ),
        ),
        drawer: AppDrawer(), // Mantenemos el Drawer en esta página.
        body: Center(
          child: Text('Settings Page Content'),
        ),
      ),
    );
  }
}
