import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/common-widgets/appbar/appbar.dart';
import 'package:proyecto_final/features/home/dummy_data/product-list.dart';
import 'package:proyecto_final/features/home/widgets/product-card.dart';
import 'package:proyecto_final/features/navigation/app-drawer.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';

class HomePage extends StatelessWidget {
  // Método para obtener el nombre del usuario desde Firestore
  Future<String> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc['username'] ??
          'Usuario'; // Valor por defecto si no se encuentra el username
    } else {
      return 'Usuario'; // Valor por defecto si no hay usuario autenticado
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<DrawerCubit>(context),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(kToolbarHeight), // Altura estándar de AppBar
          child: FutureBuilder<String>(
            future:
                getUserData(), // Llamamos a la función que obtiene el nombre
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return AppbarW(title: 'Cargando...'); // Título mientras carga
              } else if (snapshot.hasError) {
                return AppbarW(
                    title: 'Error al cargar'); // Título en caso de error
              } else if (snapshot.hasData) {
                return AppbarW(
                    title:
                        '¡Hola, ${snapshot.data}!'); // Título con el nombre del usuario
              } else {
                return AppbarW(title: '¡Hola, Usuario!'); // Título por defecto
              }
            },
          ),
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Número de columnas
              crossAxisSpacing: 5, // Espacio horizontal entre columnas
              mainAxisSpacing: 5, // Espacio vertical entre filas
              childAspectRatio: 0.8, // Relación de aspecto de las tarjetas
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];
              return ProductCard(product: product);
            },
          ),
        ),
      ),
    );
  }
}
