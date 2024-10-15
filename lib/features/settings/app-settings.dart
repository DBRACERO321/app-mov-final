import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/navigation/presentation/app-drawer.dart';
import 'package:proyecto_final/features/navigation/presentation/cubit/drawer-cubit.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<DrawerCubit>(context), // Reutiliza el estado del Drawer.
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        drawer: AppDrawer(), // Mantenemos el Drawer en esta página.
        body: Center(
          child: Text('Settings Page Content'),
        ),
      ),
    );
  }
}
