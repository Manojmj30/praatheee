import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'View/cart_page.dart';

import 'View/checkout_page.dart';
import 'View/product_page.dart';
import 'provider/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        home: ProductPage(),
        routes: {
          '/cart': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
        },
      ),
    );
  }
}
