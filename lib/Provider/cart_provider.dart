import 'package:flutter/material.dart';

import '../Model/product_model.dart';


class CartProvider with ChangeNotifier {
  List<Product> _cart = [];

  List<Product> get cart => _cart;

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  double get totalAmount {
    return _cart.fold(0.0, (sum, item) => sum + item.price);
  }
}
