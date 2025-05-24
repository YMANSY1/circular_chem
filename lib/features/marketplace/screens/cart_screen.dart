import 'package:circular_chem_app/features/marketplace/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());

    return Obx(() {
      print(
          'Building cart screen with ${cartController.cartItems.length} items');

      if (cartController.cartItems.isEmpty) {
        return Center(
          child: Text('Your cart is empty'),
        );
      }

      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartController.cartItems[index];
                return CartItemCard(
                  cartItem: cartItem,
                  quantity: cartItem.quantity,
                  onIncrement: () {
                    cartController.incrementQuantity(cartItem);
                  },
                  onDecrement: () {
                    cartController.decrementQuantity(cartItem);
                  },
                  onRemove: () {
                    cartController.removeFromCart(cartItem);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CheckoutScreen())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Total E£${cartController.calculateTotal()}'),
              ),
            ),
          )
        ],
      );
    });
  }
}
