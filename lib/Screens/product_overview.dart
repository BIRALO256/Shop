import 'package:flutter/material.dart';

import '../Wigdets/Product_grid.dart';

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
                child: Text('Only Favorite'),
                value: FilterProducts.favourite,
              ),
              const PopupMenuItem(
                child: Text('All Products'),
                value: FilterProducts.all,
              ),
            ],
          )
        ],
      ),
      body: ProductGrid(
        showProduct: _showOnlyFavorites,
      ),
    );
  }
}
