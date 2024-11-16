import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importamos Firestore
import 'custom_text_field.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _usernameError = '';
  String _emailError = '';
  bool _isLoading = false; // Estado de carga

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<bool> _isUsernameTaken(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isNotEmpty;
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (!_isValidEmail(_emailController.text.trim())) {
        setState(() {
          _emailError = 'Por favor ingrese un correo electrónico válido';
        });
        return;
      } else {
        setState(() {
          _emailError = '';
        });
      }

      bool isTaken = await _isUsernameTaken(_usernameController.text.trim());
      if (isTaken) {
        setState(() {
          _usernameError = 'Este nombre de usuario ya está en uso';
        });
        return;
      }

      try {
        setState(() {
          _isLoading = true; // Activa el indicador de carga
        });

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _usernameController.text.trim(),
          'phone': _phoneController.text.trim(),
          'email': _emailController.text.trim(),
          'createdAt': Timestamp.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro exitoso')),
        );

        Navigator.pushReplacementNamed(context, '/auth');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Este correo ya está registrado')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.message}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Desactiva el indicador de carga
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
                return 'Por favor ingrese un correo válido';
              }
              if (!_isValidEmail(value)) {
                return 'Correo no válido';
              }
              return null;
            },
          ),
          if (_emailError.isNotEmpty)
            Text(
              _emailError,
              style: TextStyle(color: Colors.red, fontSize: 14),
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
            controller: _usernameController,
            labelText: 'Nombre de usuario',
            prefixIcon: Icon(Icons.person, color: Colors.lightBlue),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre de usuario';
              }
              return null;
            },
          ),
          if (_usernameError.isNotEmpty)
            Text(
              _usernameError,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          SizedBox(height: 20),
          CustomTextField(
            controller: _phoneController,
            labelText: 'Número de teléfono',
            prefixIcon: Icon(Icons.phone, color: Colors.lightBlue),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un número de teléfono';
              }
              if (value.length != 10) {
                return 'El teléfono debe tener 10 números';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          _isLoading
              ? CircularProgressIndicator() // Muestra el indicador de carga
              : ElevatedButton(
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
