import 'package:flutter/material.dart';
import 'package:jadwal_sholat/presentation/pages/home_page.dart';

class AppRoutes {
  static MaterialPageRoute<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        });
    }
  }
}
