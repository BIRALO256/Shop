import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Wigdets/drawer.dart';

import '../Wigdets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/Orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const MyDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, i) => OrderItem(order: ordersData.orders[i]),
      ),
    );
  }
}
