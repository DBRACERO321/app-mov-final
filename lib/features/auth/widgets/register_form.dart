import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
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

  String? _validateEmail(String? value) {
    final emailPattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    if (value == null || !RegExp(emailPattern).hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomTextField(
            controller: _usernameController,
            labelText: 'Usuario',
            prefixIcon: Icon(Icons.person, color: Colors.lightBlue),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un usuario';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: _passwordController,
            labelText: 'Contraseña',
            prefixIcon: Icon(Icons.lock, color: Colors.lightBlue),
            obscureText: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: _emailController,
            labelText: 'Email',
            prefixIcon: Icon(Icons.email, color: Colors.lightBlue),
            validator: _validateEmail,
          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: _phoneController,
            labelText: 'Celular',
            prefixIcon: Icon(Icons.phone, color: Colors.lightBlue),
            keyboardType: TextInputType.phone,
            validator: _validatePhone,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registro exitoso')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Text('Registrar', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
