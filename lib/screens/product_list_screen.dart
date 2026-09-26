import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/product_data.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
            },
            icon: Badge(
              label: Text(cartProvider.totalItems.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                context.read<CartProvider>().setSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: cartProvider.searchQuery.isNotEmpty
                    ? IconButton(
                  onPressed: () {
                    context.read<CartProvider>().setSearchQuery('');
                  },
                  icon: const Icon(Icons.clear),
                )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    itemCount: cartProvider.filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.58,
              ),
              itemBuilder: (context, index) {
                final product = cartProvider.filteredProducts[index];

                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.image,
                          style: const TextStyle(fontSize: 50),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '৳${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<CartProvider>()
                                  .addToCart(product);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} added to cart',
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}