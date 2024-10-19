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
                    bottom: BorderSide(color: Colors.amber, width: 2.0))),
            child: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Buzz & Bloom',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.amber),
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
