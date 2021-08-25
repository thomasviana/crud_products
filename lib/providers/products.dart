import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_products/models/product.dart';
import 'package:flutter/material.dart';

final _fireStore = FirebaseFirestore.instance;

class Products with ChangeNotifier {
  final String userId;

  Products(this.userId);

  List<Product> _items = [
    // Product(
    //   id: 'P1',
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   name: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   stock: 10,
    //   price: 29.99,
    // ),
    // Product(
    //   id: 'P2',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   name: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   stock: 10,
    //   price: 29.99,
    // ),
    // Product(
    //   id: 'P3',
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   name: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   stock: 10,
    //   price: 29.99,
    // ),
    // Product(
    //   id: 'P4',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   name: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   stock: 10,
    //   price: 29.99,
    // ),
    // Product(
    //   id: 'P5',
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   name: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   stock: 10,
    //   price: 29.99,
    // ),
    // Product(
    //   id: 'P6',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   name: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   stock: 10,
    //   price: 29.99,
    // ),
    // Product(
    //   id: 'P7',
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   name: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   stock: 10,
    //   price: 29.99,
    // ),
    // Product(
    //   id: 'P8',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   name: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   stock: 10,
    //   price: 29.99,
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> getData() async {
    print('My userID is $userId');
    QuerySnapshot querySnapshot =
        await _fireStore.collection('users/$userId/products').get();
    final allData = querySnapshot.docs;

    List<Product> productList = [];
    for (var prod in allData) {
      final prodId = prod.id;
      final prodUrl = prod['imageUrl'];
      final prodName = prod['name'];
      final prodDescription = prod['description'];
      final prodStock = prod['stock'];
      final prodPrice = prod['price'];

      final newProduct = Product(
        id: prodId,
        imageUrl: prodUrl,
        name: prodName,
        description: prodDescription,
        stock: prodStock,
        price: prodPrice,
      );
      productList.add(newProduct);
    }
    _items = productList;
    notifyListeners();
  }

  Future<void> addProduct(String userId, Product newProduct) async {
    FirebaseFirestore.instance.collection('users/$userId/products').add(
      {
        'id': newProduct.id,
        'imageUrl': newProduct.imageUrl,
        'name': newProduct.name,
        'description': newProduct.description,
        'stock': newProduct.stock,
        'price': newProduct.price,
      },
    );
    notifyListeners();
  }

  Future<void> updateProduct(String userId, Product updatedProduct) async {
    FirebaseFirestore.instance
        .collection('users/$userId/products')
        .doc(updatedProduct.id)
        .update(
      {
        'id': updatedProduct.id,
        'imageUrl': updatedProduct.imageUrl,
        'name': updatedProduct.name,
        'description': updatedProduct.description,
        'stock': updatedProduct.stock,
        'price': updatedProduct.price,
      },
    );
    notifyListeners();
  }

  Future<void> deleteProduct(String productId) async {
    FirebaseFirestore.instance
        .collection('users/$userId/products')
        .doc(productId)
        .delete();
    notifyListeners();
    final existingProductIndex =
        _items.indexWhere((prod) => prod.id == productId);
    _items.removeAt(existingProductIndex);
    notifyListeners();
  }
}
