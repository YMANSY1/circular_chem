import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import 'echo_points_count.dart';

class CheckoutItemListTile extends StatelessWidget {
  const CheckoutItemListTile({
    super.key,
    required this.cartItem,
  });

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        cartItem.item.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text('Quantity: ${cartItem.quantity}'),
      trailing: Column(
        children: [
          Text(
            'E£${(cartItem.item.price * cartItem.quantity).toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          EcoPointsCount(
            ecoPoints:
                (cartItem.item.ecoPoints * cartItem.quantity * 1.5).round(),
            numberColor: Colors.lightBlue,
            iconSize: 16,
            textSize: 14,
          )
        ],
      ),
    );
  }
}
