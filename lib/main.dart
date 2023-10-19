import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //importing provider package

import './providers/products_provider.dart'; // making our productsclass a provider by registering it inthis main file
import '../Screens/product_overview.dart';

void main() => runApp(MyAPP());

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //registering the provider using the common used provider "change notifier"
      create: (context) =>
          ProductProvider(), // this is the  instance of the provider (products class) that is registered
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
      ),
    );
  }
}
