import 'package:flutter/material.dart';
import 'package:proyecto_final/features/navigation/entities/menu-item.entity.dart';
import 'package:proyecto_final/features/navigation/widgets/menu-item-tile.dart';

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
          return MenuItemTile(index:index,icon: item.icon,title: item.title, route: item.route);
        },
      ),
    );
  }
}
