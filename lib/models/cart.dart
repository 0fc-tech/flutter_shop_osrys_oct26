import 'package:flutter/foundation.dart';
import 'package:flutter_shop/product.dart';

class Cart extends ChangeNotifier {
  final List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  void clear() {
    _products.clear();
    notifyListeners();
  }

  List<Product> get products => _products;

  double get totalPrice => _products.fold(
    0,
    (previousValue, product) => previousValue + product.price,
  );
}
