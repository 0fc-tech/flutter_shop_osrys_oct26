import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon panier"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Votre panier total est de"),
                Spacer(),
                Text("0.00€", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Votre panier est actuellement vide"),
                Icon(Icons.photo),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
