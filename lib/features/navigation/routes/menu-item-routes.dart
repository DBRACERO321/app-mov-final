import 'package:flutter/material.dart';
import 'package:proyecto_final/features/navigation/entities/menu-item.entity.dart';

final List<MenuItem> menuItemRoutes = [
    MenuItem(title: 'Inicio', icon: Icons.home, route: '/home'),
    MenuItem(title: 'Profile', icon: Icons.person, route: '/profile'),
    MenuItem(title: 'Settings', icon: Icons.settings, route: '/settings'),
  ];