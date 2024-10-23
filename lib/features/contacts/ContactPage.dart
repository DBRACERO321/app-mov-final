import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/navigation/app-drawer.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  double opacity = 0.0; // Valor inicial de opacidad

  @override
  void initState() {
    super.initState();

    // Inicializar el AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Inicializar la animación de opacidad
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Iniciar la animación después de que la página se haya construido
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        opacity = 1.0; // Cambiar la opacidad para hacer visible el contenido
      });
      _controller.forward(); // Iniciar la animación de opacidad
    });
  }

  @override
  void dispose() {
    // Limpiar el AnimationController
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<DrawerCubit>(context),
      child: Scaffold(
         appBar: AppBar(
          title: const Text('Contacto',style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blueGrey),),
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
        drawer: AppDrawer(), // Agregar el AppDrawer aquí
        body: Container(
          color: Colors.white, // Fondo blanco para todo el contenido
          height: double.infinity, // Ocupar todo el alto disponible
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(5.0),
            child: FadeTransition(
              opacity: _opacityAnimation, // Aplicar la animación de opacidad
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 24.0),
                    child: Text(
                      'Estamos aquí para ayudarte. Nos pondremos en contacto contigo:',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(horizontal: 24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.lightBlue, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlue, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black54, width: 1.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlue, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black54, width: 1.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _messageController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: 'Mensaje',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlue, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black54, width: 1.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                final String name = _nameController.text;
                                final String email = _emailController.text;
                                final String message = _messageController.text;

                                print(
                                    'Nombre: $name, Correo: $email, Mensaje: $message');

                                _nameController.clear();
                                _emailController.clear();
                                _messageController.clear();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '¡Gracias por tu mensaje! Nos pondremos en contacto pronto.'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: Text('Enviar',
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
