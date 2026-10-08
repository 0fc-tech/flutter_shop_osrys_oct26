import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/product.dart';
import 'package:http/http.dart';

class DetailProductPage extends StatelessWidget {
  //Récupérer l'identifiant d'un produit OU le produit
  final String? idProduct;
  const DetailProductPage({super.key, required this.idProduct});

  @override
  Widget build(BuildContext context) {
    //On vérifie que l'identifiant est non null et est bien un nombre
    if (idProduct != null && int.tryParse(idProduct!) != null) {
      //On télécharge le produit
      return FutureBuilder(
        future: fetchProductById(int.parse(idProduct!)),
        builder: (context, asyncSnapshot) {
          //Si la donnée téléchargée existe on affiche le produit
          if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
            return PageProduct(product: asyncSnapshot.data!);
            //Si la donnée est en cours de téléchargement on affiche un Loader
          } else if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          //Dans tous les autres cas on affiche un texte "Introuvable"
          return Scaffold(body: Center(child: Text("Produit introuvable")));
        },
      );
    } else {
      //Si l'identifiant est null ou non numérique on
      // affiche un texte "Aucun produit trouvé"
      return Scaffold(body: Center(child: Text("Aucun produit trouvé")));
    }
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

class PageProduct extends StatelessWidget {
  final Product product;
  const new({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(product.name),
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
}
