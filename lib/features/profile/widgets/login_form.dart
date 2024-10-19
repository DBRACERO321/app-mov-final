import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Campo de Usuario
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Usuario'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su usuario';
              }
              return null;
            },
          ),
          // Campo de Contraseña
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su contraseña';
              }
              return null;
            },
          ),
          // Botón de Inicio de Sesión
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Aquí puedes poner la lógica para validar el inicio de sesión
                // Si es exitoso, navegas a la pantalla de Home
                Navigator.pushReplacementNamed(context, '/home');

                // También puedes mostrar un mensaje de éxito
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Inicio de sesión exitoso')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow, // Color de fondo del botón
            ),
            child: Text('Iniciar Sesión'),
          ),
        ],
      ),
    );
  }
}
