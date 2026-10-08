import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart.dart';
import 'package:flutter_shop/product.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListViewProducts extends StatelessWidget {
  final List<Product> products;
  final bool modeDelete;
  const new({super.key, required this.products, this.modeDelete = false});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, _) => Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => context.go('detail/${products[index].id}'),
          leading: Image.network(products[index].image, width: 70),
          title: Text(products[index].name, maxLines: 3),
          subtitle: Text(
            products[index].getPriceInEuro(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          trailing: TextButton(
            onPressed: () {
              if (modeDelete) {
                context.read<Cart>().removeProduct(products[index]);
              } else {
                context.read<Cart>().addProduct(products[index]);
              }
            },
            child: Text(modeDelete ? "Retirer" : "Ajouter".toUpperCase()),
          ),
        );
      },
    );
  }
}
