import 'package:flutter_shop/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart.g.dart';

@riverpod
class Cart extends _$Cart {
  @override
  List<Product> build() {
    return [];
  }

  void addProduct(Product product) {
    state = [...state, product];
  }

  void removeProduct(Product product) {
    final products = [...state];
    products.remove(product);
    state = products;
    //state = [...state..remove(product)];
  }

  void clear() {
    state = [];
  }

  double get totalPrice =>
      state.fold(0, (previousValue, product) => previousValue + product.price);
}
