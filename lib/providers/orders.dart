import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount; //quantity of items * price
  final List<CartItem> products; // the products in that order
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime}); // the time that order was placed
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartproducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartproducts,
        dateTime: DateTime.now(),
      ),
    ); //when we use  inser ,the most recent orders are places at the being of the list but when we use the order methode it's puts the new order at the end of the list
    notifyListeners();
  }
}
