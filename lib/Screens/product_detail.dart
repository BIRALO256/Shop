import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title1;
  // const ProductDetailScreen(this.title1, {super.key});
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)?.settings.arguments as String; // gives us the id
    final jovic = Provider.of<ProductProvider>(context,listen: false).findbyId(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(jovic.title),
      ),
    );
  }
}
