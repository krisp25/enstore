import 'package:ecommerce/models/productmodel.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductModel> _products = [];

  List<ProductModel> get getProducts {
    return [..._products];
  }

  void addProduct(ProductModel product) {
    final receivedProduct = ProductModel(
      title: product.title,
      imageURL: product.imageURL,
      description: product.description,
      price: product.price,
      actualPrice: product.actualPrice,
    );

    _products.add(receivedProduct);
    notifyListeners();
  }
}
