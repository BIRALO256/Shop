import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as orde;

class OrderItem extends StatelessWidget {
  final orde.OrderItem order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(
              DateFormat("dd MM YYYY hh:mm").format(order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.expand_more),
            ),
          )
        ],
      ),
    );
  }
}
