import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'custom_text_field.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro exitoso')),
        );
        Navigator.pushReplacementNamed(
            context, '/auth'); // Regresa a la pantalla de login.
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
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
            controller: _emailController,
            labelText: 'Correo electrónico',
            prefixIcon: Icon(Icons.email, color: Colors.lightBlue),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un correo válido';
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
          ElevatedButton(
            onPressed: _register,
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
