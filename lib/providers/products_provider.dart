import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class ProductProvider with ChangeNotifier {
  final List<Products> _items = [
    Products(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Products(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Products(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Products(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ]; //private property (_)
  List<Products> get items {
    return [..._items]; // duplicate of the items
  }

  Products findbyId(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<Products> get favoriteItems {
    return _items.where((productItem) => productItem.isFavorite).toList();
  }

  void addProducts(Products product) {
    final url = Uri.parse(
        'https://shop-e599a-default-rtdb.firebaseio.com/products.json');
    http.post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite
      }),
    ); //after the url, then we define other important part of the post like header,body ofthe request and others more
    final newProduct = Products(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
    // _items.add(newProduct);//this just inserts the products in the last inidex of the mapp in the list
    _items.insert(0,
        newProduct); //the new product will be insertedat the start of the list but by defaul it is iserted ata rhe end if you donit use this methode

    notifyListeners();
  }

  void updateProduct(String id, Products editedProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    _items[prodIndex] =
        editedProduct; //overide the product which was initially thire with the new edited product
    notifyListeners();
  }

  void deleteProduct(String iD) {
    _items.removeWhere((product) => product.id == iD);
    notifyListeners();
  }
}
