import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shop/models/cart.dart';
import 'package:flutter_shop/presentation/widgets/list_view_products.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon panier"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: cart.isEmpty
          ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowTotal(total: 0),
                ),
                EmptyCart(),
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowTotal(
                    total: ref.watch(cartProvider.notifier).totalPrice,
                  ),
                ),
                Expanded(
                  child: ListViewProducts(products: cart, modeDelete: true),
                ),
              ],
            ),
    );
  }
}

class RowTotal extends StatelessWidget {
  final num total;
  const new({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Votre panier total est de"),
        Spacer(),
        Text(
          "${total.toStringAsFixed(2)}€",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class EmptyCart extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Votre panier est actuellement vide"),
          Icon(Icons.photo),
        ],
      ),
    );
  }
}
