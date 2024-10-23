import 'package:flutter/material.dart';
import 'package:proyecto_final/features/navigation/routes/menu-item-routes.dart';
import 'package:proyecto_final/features/navigation/widgets/expanded-menu.dart';

class AppDrawer extends StatelessWidget {
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
                    bottom: BorderSide(color: Colors.lightBlue, width: 2.0))),
            child: Center(
                child: Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 200,
              )),
          ),
          ExpandedMenu(
            menuItemRoutes: menuItemRoutes,
          ),
        ],
      ),
    );
  }
}
