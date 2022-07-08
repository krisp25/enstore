import 'package:ecommerce/models/productmodel.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<ProductModel> _cartProducts = [];

  List<ProductModel> get getCartProducts {
    return [..._cartProducts];
  }

  void addToCart(ProductModel product) {
    _cartProducts.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartProducts.removeWhere((element) => element.title == product.title);
    notifyListeners();
  }

  void removeAll() {
    _cartProducts.clear();
    notifyListeners();
  }
}