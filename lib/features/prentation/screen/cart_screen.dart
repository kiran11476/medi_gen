import 'package:flutter/material.dart';
import 'package:medi_gen/features/prentation/provider/controller.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Consumer<CategoryProvider>(
        builder: (context, cartProvider, child) {
          return ListView.builder(
            itemCount: cartProvider.cartItems.length,
            itemBuilder: (context, index) {
              final meal = cartProvider.cartItems[index];
              return ListTile(
                leading: Image.network(meal.imageUrl),
                title: Text(meal.name),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    cartProvider.removeToCart(meal);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
