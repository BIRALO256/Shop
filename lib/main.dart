import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Screens/cart_screen.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';

import './providers/products_provider.dart';
import '../Screens/order_screen.dart';
import '../Screens/product_detail.dart';
import '../Screens/product_overview.dart';

void main() => runApp(const MyAPP());

class MyAPP extends StatelessWidget {
  const MyAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //registering the provider using the common used provider "change notifier"
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen()
        },
      ),
    );
  }
}
