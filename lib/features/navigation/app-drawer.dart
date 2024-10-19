import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/navigation/entities/drawer-state.entity.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';
import 'package:proyecto_final/features/navigation/routes/menu-item-routes.dart';

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
              bottom: BorderSide(
                color: Colors.amber, // bottom border color
                width: 2.0, // width border bottom
              ),
            )),
            child: Container(
              margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Buzz & Bloom',
                  textAlign: TextAlign.left,     
                  style: TextStyle(color:Colors.amber),           
                )),
          ),
          Expanded(
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
                        color: isSelected ? Colors.amber : Colors.amber,
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
          ),
        ],
      ),
    );
  }
}
