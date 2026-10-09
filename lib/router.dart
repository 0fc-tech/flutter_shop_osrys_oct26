import 'package:flutter_shop/presentation/pages/cart_page.dart';
import 'package:flutter_shop/presentation/pages/detail_product_page.dart';
import 'package:flutter_shop/presentation/pages/error_page.dart';
import 'package:flutter_shop/presentation/pages/list_products_page.dart';
import 'package:flutter_shop/presentation/pages/map_shops_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  errorBuilder: (context, state) => ErrorPage(state: state),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ListProductsPage(),
      routes: [
        GoRoute(
          path: 'cart',
          builder: (context, state) => const CartPage(),
          routes: [
            GoRoute(path: 'map', builder: (context, state) => MapShopsPage()),
          ],
        ),
        GoRoute(
          path: 'detail/:idProduct',
          builder: (context, state) =>
              DetailProductPage(idProduct: state.pathParameters['idProduct']),
        ),

        //Routage Detail
      ],
    ),
  ],
);
