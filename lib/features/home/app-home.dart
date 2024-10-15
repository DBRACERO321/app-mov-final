import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/navigation/presentation/app-drawer.dart';
import 'package:proyecto_final/features/navigation/presentation/cubit/drawer-cubit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DrawerCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: AppDrawer(),
        body: Center(
          child: Text('Home Page Content'),
        ),
      ),
    );
  }
}
