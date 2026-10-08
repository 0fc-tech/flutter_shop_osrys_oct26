import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/product.dart';
import 'package:http/http.dart';

const product = Product(
  id: 1,
  name: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
  description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
  price: 109.95,
  image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
  category: "men's clothing",
);

class DetailProductPage extends StatelessWidget {
  //Récupérer l'identifiant d'un produit OU le produit
  final String? idProduct;
  const DetailProductPage({super.key, required this.idProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('appbarTitle'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.network(product.image, height: 350),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    product.getPriceInEuro(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product.description),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              width: MediaQuery.of(context).size.width,
              child: FilledButton(
                onPressed: () {},
                child: Text("Ajouter au panier"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Product> fetchProductById(int id) async {
    //On vient télécharger la liste des produits
    final responseProduct = await get(
      Uri.parse("https://fakestoreapi.com/products/$id"),
    );
    if (responseProduct.statusCode == 200) {
      return Product.fromMap(jsonDecode(responseProduct.body));
    } else {
      return Future.error("Erreur de téléchargement");
    }
  }
}
