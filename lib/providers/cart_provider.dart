import 'package:flutter/foundation.dart';

import '../data/product_data.dart';
import '../models/cart_item.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    final index = _cartItems.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(
        CartItem(product: product),
      );
    }

    notifyListeners();
  }

  void increaseQuantity(ProductModel product) {
    final index = _cartItems.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index != -1) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(ProductModel product) {
    final index = _cartItems.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }

      notifyListeners();
    }
  }

  void removeFromCart(ProductModel product) {
    _cartItems.removeWhere(
          (item) => item.product.id == product.id,
    );

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int get totalItems {
    int total = 0;

    for (final item in _cartItems) {
      total += item.quantity;
    }

    return total;
  }

  double get subtotal {
    double total = 0;

    for (final item in _cartItems) {
      total += item.product.price * item.quantity;
    }

    return total;
  }

  double get discount {
    if (subtotal > 2000) {
      return subtotal * 0.10;
    }

    return 0;
  }

  double get finalTotal {
    return subtotal - discount;
  }


  List<ProductModel> get filteredProducts {
    if (_searchQuery.isEmpty) {
      return products;
    }

    return products.where((product) {
      return product.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
    }).toList();
  }

}