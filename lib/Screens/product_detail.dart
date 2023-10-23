import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title1;
  const ProductDetailScreen(this.title1, {super.key});

  @override
  Widget build(BuildContext context) {
    final id = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title1),
      ),
    );
  }
}
