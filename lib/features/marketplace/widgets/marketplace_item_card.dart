import 'package:circular_chem_app/features/marketplace/controllers/cart_controller.dart';
import 'package:circular_chem_app/features/marketplace/models/cart_item.dart';
import 'package:circular_chem_app/features/marketplace/models/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'echo_points_count.dart';

class MarketplaceItemCard extends StatelessWidget {
  final Item item;

  const MarketplaceItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.blue.withOpacity(0.2),
      highlightColor: Colors.blue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Image placeholder
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  image: item.imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(item.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 16),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(item.sellingCompany.companyName,
                        style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(height: 4),
                    Text(item.category.name,
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    EcoPointsCount(
                      ecoPoints: item.ecoPoints,
                      numberColor: Colors.lightBlue,
                      iconSize: 20,
                      textSize: 18,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(item.rating.toString()),
                        const Spacer(),
                        Text(
                          'E£${item.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        // Add to Cart Button
                        IconButton(
                          icon: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            // Get the existing controller instance (don't create a new one)
                            final cartController = Get.find<CartController>();

                            final existingItemIndex =
                                cartController.cartItems.indexWhere(
                              (cartItem) => cartItem.item == item,
                            );

                            if (existingItemIndex != -1) {
                              // Item exists, increment quantity
                              final existingItem =
                                  cartController.cartItems[existingItemIndex];
                              cartController.incrementQuantity(existingItem);
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content: Text(
                                        'Increased quantity to ${existingItem.quantity} for ${existingItem.item.name}')));
                            } else {
                              // Item doesn't exist, add new item
                              final cartItem = CartItem(item: item);
                              cartController.addToCart(cartItem);
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content: Text(
                                        'Added ${cartItem.item.name} to cart')));
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
