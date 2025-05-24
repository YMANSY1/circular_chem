import 'package:circular_chem_app/features/marketplace/models/order.dart'
    as orderModel;
import 'package:circular_chem_app/features/marketplace/services/order_service.dart';
import 'package:circular_chem_app/features/marketplace/widgets/custom_list_tile.dart'; // Import CustomListTile
import 'package:circular_chem_app/features/marketplace/widgets/item_expansion_tile.dart'; // Import ItemExpansionTile
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final future = OrderService(FirebaseFirestore.instance).getUserOrders();

    return Scaffold(
      body: FutureBuilder<List<orderModel.Order>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading orders: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          } else {
            final orders = snapshot.data!.reversed.toList();
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ItemExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          order.isDelivered ? Colors.green : Colors.orange,
                      child: Icon(
                        order.isDelivered
                            ? Icons.check_circle_outline
                            : Icons.pending_actions,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Order ID: ${order.id.substring(0, 6)}...', // Display a truncated ID
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total: \$${order.totalPrice.toStringAsFixed(2)}'),
                        Text(
                          'Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(order.orderDate)}',
                        ),
                        Text(
                            'Status: ${order.isDelivered ? 'Delivered' : 'Pending'}'),
                      ],
                    ),
                    detailTiles: order.items.map((cartItem) {
                      final item = cartItem.item;
                      return CustomListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              item.imageUrl != null && item.imageUrl!.isNotEmpty
                                  ? NetworkImage(item.imageUrl!)
                                  : null,
                          child: item.imageUrl == null || item.imageUrl!.isEmpty
                              ? const Icon(Icons.image_not_supported,
                                  color: Colors.grey)
                              : null,
                        ),
                        title: '${item.name} (x${cartItem.quantity})',
                        subtitle:
                            'Price: \$${(item.price * cartItem.quantity).toStringAsFixed(2)} | Eco Points: ${item.ecoPoints * cartItem.quantity}',
                      );
                    }).toList(),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
