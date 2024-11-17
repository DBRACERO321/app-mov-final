import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../common-widgets/userstyle/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Estado de carga

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        Navigator.pushReplacementNamed(
          context,
          '/home',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inicio de sesión exitoso')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Correo o contraseña incorrectos.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
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
                return 'Por favor ingrese su correo electrónico';
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
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su contraseña';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          _isLoading
              ? CircularProgressIndicator() // Muestra el indicador de carga
              : ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text('Iniciar Sesión', style: TextStyle(fontSize: 18)),
                ),
        ],
      ),
    );
  }
}
