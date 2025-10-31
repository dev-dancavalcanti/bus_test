import 'package:bus_teste/config/injectors.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import 'main.route.dart';

part 'main.g.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

@Main('lib/ui/')
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bus Teste',
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.splash,
      ),
    );
  }
}
