import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as orde;

class OrderItem extends StatefulWidget {
  final orde.OrderItem order;

  const OrderItem({super.key, required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat("dd/MM/yyyy hh:mm").format(widget.order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20 + 10, 100),
              child: ListView(
                children: [
                  // widget.order.products
                  //     .map(
                  //       (prod) => Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             prod.title,
                  //             style: const TextStyle(
                  //                 fontSize: 18, fontWeight: FontWeight.bold),
                  //           ),
                  //           Text(
                  //             '${prod.quatity}x \$${prod.price}',
                  //             style: const TextStyle(
                  //                 fontSize: 18, color: Colors.red),
                  //           )
                  //         ],
                  //       ),
                  //     )
                  //     .toList(),
                ],
              ), //this works in the way that you can acces the wigdet and then thr order class , finds out which products are their and then count them using the lenth formular plus if they are may you give a size of 180 so that it's not that big
            )
        ],
      ),
    );
  }
}
