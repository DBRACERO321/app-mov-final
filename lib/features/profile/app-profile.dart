import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/navigation/app-drawer.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';
import 'widgets/register_form.dart';
import 'widgets/login_form.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLogin = true; // Cambiar entre login y registro

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<DrawerCubit>(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isLogin ? 'Iniciar Sesión' : 'Registrarse'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin; // Cambiar formulario
                });
              },
              child: Text(
                isLogin ? 'Registrarse' : 'Iniciar Sesión',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        drawer: AppDrawer(), // Menú lateral (Drawer)
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLogin ? LoginForm() : RegisterForm(),
          ),
        ),
      ),
    );
  }
}
