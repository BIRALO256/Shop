import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Screens/cart_screen.dart';
import 'package:shop/providers/cart.dart';

import '../Wigdets/Product_grid.dart';
import '../Wigdets/badge.dart';
import '../Wigdets/drawer.dart';

enum FilterProducts {
  favourite,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  // ignore: unused_field
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterProducts selected) {
              setState(() {
                //Notify the framework that the internal state of this object has changed.
                if (selected == FilterProducts.favourite) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterProducts.favourite,
                child: Text('Only Favorite'),
              ),
              const PopupMenuItem(
                value: FilterProducts.all,
                child: Text('All Products'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => BadgeIcon(
              value: cartData.itemCount.toString(),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: ProductGrid(
        showProduct: _showOnlyFavorites,
      ),
    );
  }
}
