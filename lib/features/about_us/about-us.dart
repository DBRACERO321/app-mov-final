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
  List<double> _opacityList = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ]; // Inicializar opacidades

  @override
  void initState() {
    super.initState();

    // Iniciar animaciones secuenciales con diferentes retrasos
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _opacityList[0] = 1.0; // Mostrar el primer párrafo
      });
    });

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacityList[1] = 1.0; // Mostrar el segundo párrafo
      });
    });

    Future.delayed(Duration(milliseconds: 900), () {
      setState(() {
        _opacityList[2] = 1.0; // Mostrar el tercer párrafo
      });
    });

    Future.delayed(Duration(milliseconds: 1300), () {
      setState(() {
        _opacityList[3] = 1.0; // Mostrar el cuarto párrafo
      });
    });

    Future.delayed(Duration(milliseconds: 1700), () {
      setState(() {
        _opacityList[4] = 1.0; // Mostrar el botón
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<DrawerCubit>(context),
      child: Scaffold(
         appBar: AppBar(
          title: const Text('Acerca de nosotros',style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blueGrey),),
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
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Primer párrafo
              AnimatedOpacity(
                opacity: _opacityList[0], // Animar con el valor correspondiente
                duration: Duration(seconds: 1),
                child: Text(
                  'Estilo 360',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: 20),
              // Segundo párrafo
              AnimatedOpacity(
                opacity: _opacityList[1], // Animar con el valor correspondiente
                duration: Duration(seconds: 1),
                child: Text(
                  'En Estilo 360, somos apasionados por la moda y nos dedicamos a '
                  'ofrecer prendas de alta calidad que reflejan las últimas tendencias. '
                  'Nuestro objetivo es empoderar a nuestros clientes para que se sientan '
                  'cómodos y seguros en su estilo personal.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 20),
              // Tercer párrafo (ListTile)
              AnimatedOpacity(
                opacity: _opacityList[2], // Animar con el valor correspondiente
                duration: Duration(seconds: 1),
                child: ListTile(
                  leading: Icon(Icons.group, size: 40, color: Colors.lightBlue),
                  title: Text('Nuestro Equipo'),
                  subtitle: Text(
                    'Contamos con un equipo talentoso de diseñadores, estilistas y '
                    'profesionales de marketing, todos comprometidos con brindar '
                    'lo mejor a nuestros clientes.',
                  ),
                ),
              ),
              // Cuarto párrafo (ListTile)
              AnimatedOpacity(
                opacity: _opacityList[3], // Animar con el valor correspondiente
                duration: Duration(seconds: 1),
                child: ListTile(
                  leading:
                      Icon(Icons.business, size: 40, color: Colors.lightBlue),
                  title: Text('Nuestra Misión'),
                  subtitle: Text(
                    'Nuestra misión es proporcionar moda accesible y de calidad que '
                    'inspire a nuestros clientes a expresarse a través de su vestimenta.',
                  ),
                ),
              ),
              // Quinto párrafo (ListTile)
              AnimatedOpacity(
                opacity: _opacityList[4], // Animar con el valor correspondiente
                duration: Duration(seconds: 1),
                child: ListTile(
                  leading: Icon(Icons.star, size: 40, color: Colors.lightBlue),
                  title: Text('Nuestros Valores'),
                  subtitle: Text(
                    'En Estilo Urbano, valoramos la creatividad, la sostenibilidad y la '
                    'inclusividad. Creemos que la moda debe ser para todos, sin importar '
                    'su tamaño o estilo.',
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Botón
              AnimatedOpacity(
                opacity: _opacityList[4], // Animar el botón al final
                duration: Duration(seconds: 1),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Redirigir a la página de contactos
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: Text('Contáctanos', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
