import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Screens/edit_product_screen.dart';
import 'package:shop/Wigdets/drawer.dart';
import 'package:shop/Wigdets/user_product_items.dart';

import '../providers/products_provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                  id: productData.items[i].id,
                  title: productData.items[i].title,
                  imageUrl: productData.items[i].imageUrl),
              // const Divider(),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
