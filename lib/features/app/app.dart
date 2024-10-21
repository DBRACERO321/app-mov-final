import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final/features/about_us/about-us.dart';
import 'package:proyecto_final/features/contacts/ContactPage.dart';
import 'package:proyecto_final/features/home/app-home.dart';
import 'package:proyecto_final/features/navigation/cubit/drawer.cubit.dart';
import 'package:proyecto_final/features/profile/app-profile.dart';
import 'package:proyecto_final/features/settings/app-settings.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerCubit(),
      child: MaterialApp(
        title: 'Buzz & Bloom',
        initialRoute: '/profile',
        routes: {
          '/home': (context) => HomePage(),
          '/profile': (context) => ProfilePage(),
          '/settings': (context) => SettingsPage(),
          '/about_us': (context) => AboutUsPage(),
          '/contacts': (context) => ContactPage(),
        },
      ),
    );
  }
}
