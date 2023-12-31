import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products_provider.dart';

import './product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showProduct;

  const ProductGrid({super.key, required this.showProduct});
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(
        context); //here we are creating using a provider to create an object which is productsdata and this is possible because the provider methode is generic<>
    final products = showProduct
        ? productsData.favoriteItems
        : productsData
            .items; // items is the get methode we defined for getting the duplicate of the list in productprovide class
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        // create: (context) =>
        value: products[
            i], //we use .value instead of a context incase the data we are providing is for a grid or a list
        child: ProductItem(
            //   products[i].id,
            //   products[i].title,
            //   products[i].imageUrl,
            ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
