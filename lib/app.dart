import 'package:flutter/material.dart';
import 'package:flutter_shop/router.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';

class FlutterShopApp extends StatelessWidget {
  const FlutterShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Cart(),
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
