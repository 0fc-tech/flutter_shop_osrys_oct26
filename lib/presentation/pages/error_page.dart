import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  final GoRouterState state;
  const ErrorPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline),
            Text("La route ${state.uri} n'existe pas"),
            Text("Revenir vers la page d'accueil"),
            OutlinedButton(
              onPressed: () => context.go('/'),
              child: Text("Accueil"),
            ),
          ],
        ),
      ),
    );
  }
}
