import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';
import 'package:proyecto_final/features/navigation/entities/drawer-state.entity.dart';
import 'package:proyecto_final/features/navigation/entities/menu-item.entity.dart';

class ExpandedMenu extends StatelessWidget {
  final List<MenuItem> menuItemRoutes;

  const ExpandedMenu({Key? key, required this.menuItemRoutes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: menuItemRoutes.length,
        itemBuilder: (context, index) {
          final item = menuItemRoutes[index];
          return BlocBuilder<DrawerCubit, DrawerState>(
            builder: (context, state) {
              final isSelected = state.selectedIndex == index;
              return ListTile(
                leading: Icon(
                  item.icon,
                  color: isSelected ? Colors.amber : Colors.black,
                ),
                title: Text(
                  item.title,
                  style: TextStyle(
                    color: isSelected ? Colors.amber : Colors.black,
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
    );
  }
}
