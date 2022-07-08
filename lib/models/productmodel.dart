import 'package:flutter/material.dart';

class ProductModel {
  final String? title;
  final String? imageURL;
  final String? description;
  final String? price;
  final String? actualPrice;

  ProductModel({
    required this.title,
    required this.imageURL,
    required this.description,
    required this.price,
    required this.actualPrice
  });
}