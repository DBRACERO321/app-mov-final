import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/about_us/about-us.dart';
import 'package:proyecto_final/features/contacts/ContactPage.dart';
import 'package:proyecto_final/features/home/app-home.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';
import 'package:proyecto_final/features/auth/app-auth.dart';
import 'package:proyecto_final/features/settings/app-settings.dart';
import 'package:proyecto_final/features/profile/app-profile.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerCubit(),
      child: MaterialApp(
        title: 'Estilo 360',
        initialRoute: '/auth',
        routes: {
          '/home': (context) => HomePage(),
          '/auth': (context) => AuthPage(),
          '/settings': (context) => SettingsPage(),
          '/about/us': (context) => AboutUsPage(),
          '/contacts': (context) => ContactPage(),
          '/profile': (context) => ProfilePage(),
        },
      ),
    );
  }
}
