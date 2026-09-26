import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: cartProvider.cartItems.isEmpty
          ? _buildEmptyCart(context)
          : _buildCart(context, cartProvider),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add some products to your cart.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go to Products'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCart(
      BuildContext context,
      CartProvider cartProvider,
      ) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cartProvider.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartProvider.cartItems[index];
              final product = cartItem.product;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text(
                        product.image,
                        style: const TextStyle(fontSize: 40),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              '৳${product.price.toStringAsFixed(0)}',
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<CartProvider>()
                                        .decreaseQuantity(product);
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                  ),
                                ),

                                Text(
                                  cartItem.quantity.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<CartProvider>()
                                        .increaseQuantity(product);
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          context
                              .read<CartProvider>()
                              .removeFromCart(product);
                        },
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        _buildSummary(context, cartProvider),
      ],
    );
  }

  Widget _buildSummary(
      BuildContext context,
      CartProvider cartProvider,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Column(
        children: [
          _summaryRow(
            'Total Items',
            cartProvider.totalItems.toString(),
          ),

          _summaryRow(
            'Subtotal',
            '৳${cartProvider.subtotal.toStringAsFixed(0)}',
          ),

          _summaryRow(
            'Discount',
            '৳${cartProvider.discount.toStringAsFixed(0)}',
          ),

          const Divider(),

          _summaryRow(
            'Final Total',
            '৳${cartProvider.finalTotal.toStringAsFixed(0)}',
            isBold: true,
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                context.read<CartProvider>().clearCart();
              },
              child: const Text('Clear Cart'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
      String title,
      String value, {
        bool isBold = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight:
              isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight:
              isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}