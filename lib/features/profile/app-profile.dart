import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/common-widgets/appbar/appbar.dart';
import 'package:proyecto_final/features/navigation/app-drawer.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';
import 'package:proyecto_final/features/profile/widgets/update_form.dart';

class ProfilePage extends StatelessWidget {
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
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: FutureBuilder<String>(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return AppbarW(title: 'Cargando...');
              } else if (snapshot.hasError) {
                return AppbarW(title: 'Error al cargar');
              } else if (snapshot.hasData) {
                return AppbarW(title: '¡Hola, ${snapshot.data}!');
              } else {
                return AppbarW(title: '¡Hola, Usuario!'); // Título por defecto
              }
            },
          ),
        ),
        drawer: AppDrawer(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Añadir el logo de imagen
                Image.asset(
                  'assets/images/logo.png',
                  width: 300,
                  height: 200,
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
                    child: UpdateProfileForm(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
