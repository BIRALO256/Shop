import 'package:flutter/material.dart';
import 'package:shop/Screens/user_product_screen.dart';

import '../Screens/order_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Freind'),
            automaticallyImplyLeading:
                false, //this means it will never add a back button the way you see other app bars which have a back button
          ),
          const Divider(
            height: 5,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(
            height: 5,
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Order(s)'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Product'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
