import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/home/dummy_data/product-list.dart';
import 'package:proyecto_final/features/home/widgets/product-card.dart';
import 'package:proyecto_final/features/navigation/app-drawer.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<DrawerCubit>(context),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Inicio',style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blueGrey),),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // number of columns
              crossAxisSpacing: 5, //horizontal space
              mainAxisSpacing: 5, //vertical space
              childAspectRatio: 0.8, //aspect radio of card
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
