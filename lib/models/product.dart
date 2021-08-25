import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String name;
  final String description;
  final int stock;
  final int price;

  Product(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.description,
      required this.stock,
      required this.price});
}
