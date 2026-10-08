import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart.dart';
import 'package:flutter_shop/presentation/widgets/list_view_products.dart';
import 'package:flutter_shop/product.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ListProductsPage extends StatelessWidget {
  const ListProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('appbarTitle'),
        actions: [
          IconButton(
            onPressed: () {
              context.go('cart');
            },
            icon: Badge.count(
              count: context.watch<Cart>().products.length,
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchListProducts(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData && asyncSnapshot.data?.isNotEmpty == true) {
            return ListViewProducts(products: asyncSnapshot.data!);
          } else {
            return Text(asyncSnapshot.error?.toString() ?? "erreur inconnue");
          }
        },
      ),
    );
  }

  Future<List<Product>> fetchListProducts() async {
    //On vient télécharger la liste des produits
    final responseProducts = await get(
      Uri.parse("https://fakestoreapi.com/products"),
    );
    if (responseProducts.statusCode == 200) {
      //On transforme la réponse String en List de Map (manipulable en Dart)
      final listMap = jsonDecode(responseProducts.body) as List;
      //Pour chaque Map dans la liste on fait correspondre à un Product
      final listProducts = listMap
          .map((map) => Product.fromMap(map as Map<String, dynamic>))
          .toList();
      //On retourne la nouvelle liste de produits
      return listProducts;
    } else {
      return Future.error("Erreur de téléchargement");
    }
  }
}
