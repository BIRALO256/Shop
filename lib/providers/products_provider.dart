import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class ProductProvider with ChangeNotifier {
  List<Products> _items = [
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

  Future<void> fetchProducts() async {
    final url = Uri.parse(
        'https://shop-e599a-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      // print(json.decode(response.body));
      final extractedProduct =
          json.decode(response.body) as Map<String, dynamic>;
      final List<Products> loadedProduct = [];
      extractedProduct.forEach((productID, productData) {
        loadedProduct.add(Products(
            id: productID,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite']));
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProducts(Products product) async {
    final url = Uri.parse(
        'https://shop-e599a-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        }),
      );
      final newProduct = Products(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      // _items.add(newProduct);//this just inserts the products in the last inidex of the mapp in the list
      _items.insert(0,
          newProduct); //the new product will be insertedat the start of the list but by defaul it is iserted ata rhe end if you donit use this methode

      notifyListeners();
    } catch (error) {
      throw error;
    }
    //this function runs after receiving the future response ,it is not worked on imediatly ruther after sending the data to the Firebase API , then we run this code in THEN function

    //after the url, then we define other important part of the post like header,body ofthe request and others more
  }

  Future<void> updateProduct(String id, Products editedProduct) async {
    final url = Uri.parse(
        'https://shop-e599a-default-rtdb.firebaseio.com/products/$id.json');
    await http.patch(url,
        body: json.encode({
          'description': editedProduct.description,
          'imageUrl': editedProduct.imageUrl,
          'price': editedProduct.price,
          'title': editedProduct.title,
        }));
    // try {} catch (error) {}
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    _items[prodIndex] =
        editedProduct; //overide the product which was initially there with the new edited product
    notifyListeners();
  }

  void deleteProduct(String iD) {
    final url = Uri.parse(
        'https://shop-e599a-default-rtdb.firebaseio.com/products/$iD.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == iD);
    var existingProduct = _items[existingProductIndex];
    http.delete(url).then((response) {
      if (response.statusCode >= 400) {}
      // existingProduct = Null;
    }).catchError((_) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners(); // incase you face an error in deleting the prduct is re inserted in the list , meaning not deleted officially
    });
    _items.removeWhere((product) => product.id == iD);
    notifyListeners();
  }
}
