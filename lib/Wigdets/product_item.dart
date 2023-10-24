import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/product_detail.dart';
import '../providers/product.dart';

/// this is the grid item which will be rendered for every item
class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
                product.isFavorite ? Icons.favorite_border : Icons.favorite),
            color: Colors.orange.withOpacity(0.7),
          ),
          trailing: IconButton(
            onPressed: () {
              product.toggleFavoriteStatus();
            },
            icon: const Icon(Icons.shopping_cart),
            color: Colors.orange.withOpacity(1),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
