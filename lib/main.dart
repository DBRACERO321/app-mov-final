import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/home/app-home.dart';
import 'package:proyecto_final/features/navigation/presentation/cubit/drawer-cubit.dart';
import 'package:proyecto_final/features/profile/app-profile.dart';
import 'package:proyecto_final/features/settings/app-settings.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerCubit(),
      child: MaterialApp(
        title: 'Flutter Drawer Example',
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomePage(),
          '/profile': (context) => ProfilePage(),
          '/settings': (context) => SettingsPage(),
        },
      ),
    );
  }
}
