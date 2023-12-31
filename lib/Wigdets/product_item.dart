import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

import '../Screens/product_detail.dart';
import '../providers/product.dart';

/// this is the grid item which will be rendered for every item
class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Products>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return Consumer<Products>(
      //using consumer a listerner you the wigdet cahnges only in this particular section but with provider it change thw whole of it
      builder: (context, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            leading: IconButton(
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.orange.withOpacity(0.7),
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar(); //this one hide the current one and displays the new snack bar incase you rapidly add items to cart
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Added item to cart',
                      style: TextStyle(color: Colors.amber),
                    ),
                    duration: const Duration(
                        seconds: 3), //how long it takes to disapper
                    action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ),
                ); //this esterblishs a connection to the narest scafold in  short .of(context),like in provide it's like  a river where you tap in for something
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
        ),
      ),
    );
  }
}
