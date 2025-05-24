import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove; // Callback for removing the item

  const CartItemCard({
    super.key,
    required this.cartItem,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (quantity == 0) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                image: cartItem.item.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(cartItem.item.imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: cartItem.item.imageUrl == null
                  ? const Icon(Icons.shopping_bag_outlined,
                      size: 40, color: Colors.grey)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cartItem.item.sellingCompany.companyName,
                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  // Price and Quantity Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'E£${(cartItem.item.price * quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove,
                                  size: 20, color: Colors.blue),
                              onPressed: onDecrement,
                              visualDensity: VisualDensity.compact,
                            ),
                            Text(
                              '$quantity', // Use the passed quantity
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add,
                                  size: 20, color: Colors.blue),
                              onPressed: onIncrement,
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Remove Button
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                onRemove();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..clearSnackBars()
                  ..showSnackBar(
                    SnackBar(
                        content:
                            Text('${cartItem.item.name} removed from cart')),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
