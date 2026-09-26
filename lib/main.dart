import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_card_app/providers/cart_provider.dart';
import 'package:shopping_card_app/screens/product_list_screen.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (BuildContext context) =>CartProvider(),
          child: const ShoppingCardApp()
      )
  );
}

class ShoppingCardApp extends StatelessWidget {
  const ShoppingCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Cart App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }
}
