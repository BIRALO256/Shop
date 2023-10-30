import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quatity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quatity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    //this  returns a copy of the map of cart items from the orignial map to avoid manuplation of the original map
    return {..._items};
  }

//items in  the coart
  int get itemCount {
    // ignore: unnecessary_null_comparison
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.quatity * CartItem.price;
    });
    return total;
  }

  // function to add items in the Map
  void addItem(String productId, double price, String title) {
// first checking if the product alreaddy exists in the cart so that we can only add the quatity of the product or add a new product to the cart
    if (_items.containsKey(productId)) {
      // change the quatity of the existing product in the cart
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quatity: existingCartItem.quatity + 1));
    } else {
      //add a new products
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quatity: 1));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
