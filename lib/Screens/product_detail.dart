import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title1;
const ProductDetailScreen(this.title1, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title1),
      ),
    );
  }
}
