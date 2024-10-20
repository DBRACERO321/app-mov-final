import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/navigation/app-drawer.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';
import 'package:proyecto_final/features/contacts/ContactPage.dart'; // Asegúrate de importar la página de contacto

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  double _opacity = 0.0; // Valor inicial de opacidad

  @override
  void initState() {
    super.initState();
    // Iniciar la animación después de que la página se haya construido
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0; // Cambiar la opacidad para hacer visible el texto
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<DrawerCubit>(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Acerca de Nosotros'),
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedOpacity(
                opacity: _opacity, // Usar el valor de opacidad
                duration: Duration(seconds: 1), // Duración de la animación
                child: Text(
                  'Estilo Urbano',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _opacity, // Usar el valor de opacidad
                duration: Duration(seconds: 1), // Duración de la animación
                child: Text(
                  'En Estilo Urbano, somos apasionados por la moda y nos dedicamos a '
                  'ofrecer prendas de alta calidad que reflejan las últimas tendencias. '
                  'Nuestro objetivo es empoderar a nuestros clientes para que se sientan '
                  'cómodos y seguros en su estilo personal.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.group, size: 40),
                title: Text('Nuestro Equipo'),
                subtitle: Text(
                  'Contamos con un equipo talentoso de diseñadores, estilistas y '
                  'profesionales de marketing, todos comprometidos con brindar '
                  'lo mejor a nuestros clientes.',
                ),
              ),
              ListTile(
                leading: Icon(Icons.business, size: 40),
                title: Text('Nuestra Misión'),
                subtitle: Text(
                  'Nuestra misión es proporcionar moda accesible y de calidad que '
                  'inspire a nuestros clientes a expresarse a través de su vestimenta.',
                ),
              ),
              ListTile(
                leading: Icon(Icons.star, size: 40),
                title: Text('Nuestros Valores'),
                subtitle: Text(
                  'En Estilo Urbano, valoramos la creatividad, la sostenibilidad y la '
                  'inclusividad. Creemos que la moda debe ser para todos, sin importar '
                  'su tamaño o estilo.',
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Redirigir a la página de contactos
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactPage()),
                    );
                  },
                  child: Text('Contáctanos'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
