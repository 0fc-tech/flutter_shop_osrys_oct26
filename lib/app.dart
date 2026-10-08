import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shop/router.dart';

class FlutterShopApp extends StatelessWidget {
  const FlutterShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Activation de Riverpod dans toute l'application
    return ProviderScope(
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.dark(primary: Colors.green),
        ),
        routerConfig: router,
      ),
    );
  }
}
