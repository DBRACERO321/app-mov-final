import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Validación de email
  String? _validateEmail(String? value) {
    final emailPattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    if (value == null || !RegExp(emailPattern).hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  // Validación de teléfono
  String? _validatePhone(String? value) {
    if (value == null || value.length != 10) {
      return 'Ingrese un número de teléfono válido (10 dígitos)';
    }
    return null;
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
                return 'Por favor ingrese un usuario';
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
              if (value == null || value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          // Campo de Email
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: _validateEmail,
          ),
          // Campo de Teléfono
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Celular'),
            keyboardType: TextInputType.phone,
            validator: _validatePhone,
          ),
          // Botón de Registro
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Procesar el formulario
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registro exitoso')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow, // Color de fondo del botón
            ),
            child: Text('Registrar'),
          ),
        ],
      ),
    );
  }
}
