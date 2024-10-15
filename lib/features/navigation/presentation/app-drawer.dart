import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/navigation/domain/entities/menu-item.dart';
import 'package:proyecto_final/features/navigation/presentation/cubit/drawer-cubit.dart';

class AppDrawer extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem(title: 'Home', icon: Icons.home, route: '/home'),
    MenuItem(title: 'Profile', icon: Icons.person, route: '/profile'),
    MenuItem(title: 'Settings', icon: Icons.settings, route: '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Colors.blue, // Color del borde inferior
                width: 2.0, // Ancho del borde inferior
              ),
            )),
            child: Center(
                child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUv9DBazkHajfO9sj2rJfOWoAZPYgjw1zcnA&s', // Ruta de la imagen
              fit: BoxFit.fitHeight, // Ajustar la imagen
            )),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return BlocBuilder<DrawerCubit, DrawerState>(
                  builder: (context, state) {
                    final isSelected = state.selectedIndex == index;
                    return ListTile(
                      leading: Icon(
                        item.icon,
                        color: isSelected ? Colors.blue : Colors.black,
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                        ),
                      ),
                      onTap: () {
                        context.read<DrawerCubit>().selectItem(index);
                        Navigator.pushReplacementNamed(context, item.route);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
