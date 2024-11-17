import 'package:flutter/material.dart';
import 'package:proyecto_final/features/navigation/entities/menu-item.entity.dart';

final List<MenuItem> menuItemRoutes = [
  MenuItem(title: 'Inicio', icon: Icons.home, route: '/home'),
  MenuItem(title: 'Ver Carrito', icon: Icons.shopping_cart, route: '/shopping/cart'),
  MenuItem(title: 'Perfil', icon: Icons.person, route: '/profile'),
  MenuItem(title: 'Settings', icon: Icons.settings, route: '/settings'),
  MenuItem(title: 'Nosotros', icon: Icons.local_mall, route: '/about/us'),
  MenuItem(title: 'Contactos', icon: Icons.contacts, route: '/contacts'),
  MenuItem(
      title: 'Cerrar sesión', icon: Icons.send_to_mobile_sharp, route: '/auth'),
];
