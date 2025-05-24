import 'package:circular_chem_app/features/marketplace/services/order_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../widgets/checkout_item_list_tile.dart';
import '../widgets/total_row.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final isDelivery = false.obs;
  final addressController = TextEditingController();
  final cartController = Get.put(CartController());

  void onDeliveryToggle(bool newValue) {
    setState(() {
      isDelivery.value = newValue;
    });
  }

  double calculateItemsTotal() {
    final cartController = Get.find<CartController>();
    return cartController.cartItems
        .fold(0.0, (total, item) => total + (item.item.price * item.quantity));
  }

  double calculateDeliveryFee() {
    return isDelivery.value ? 30.0 : 0.0;
  }

  double calculateTotalPrice() {
    return calculateItemsTotal() + calculateDeliveryFee();
  }

  Future<void> _confirmOrder() async {
    final orderService = OrderService(FirebaseFirestore.instance);

    try {
      await orderService.createOrder();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order confirmed!')),
      );

      cartController.clearCart();

      Navigator.of(context).pop();
    } catch (e) {
      print('Error confirming order: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to confirm order. Please try again. Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Receipt Header
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Divider(),

            // Receipt Items List
            SizedBox(
              height: 280,
              child: Obx(() {
                return ListView.separated(
                  itemCount: cartController.cartItems.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final cartItem = cartController.cartItems[index];
                    print('Eco Points are ${cartItem.item.ecoPoints * 1.5}');
                    return CheckoutItemListTile(cartItem: cartItem);
                  },
                );
              }),
            ),

            const SizedBox(height: 16),

            // Delivery Option
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Do You Want This Order Delivered?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: isDelivery.value,
                    onChanged: onDeliveryToggle,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Address Field
            Obx(() {
              return TextFormField(
                enabled: isDelivery.value,
                controller: addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Delivery Address',
                  hintText: 'Enter your delivery address',
                ),
              );
            }),

            const SizedBox(height: 20),

            // Price Breakdown
            Obx(() {
              return Column(
                children: [
                  // Items Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Items Total:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'E£${calculateItemsTotal().toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  if (isDelivery.value) ...[
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Delivery Fee:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'E£${calculateDeliveryFee().toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Divider()
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],

                  // Total Price
                  Column(
                    children: [
                      TotalRow(
                        label: 'Total Price:',
                        value: 'E£${calculateTotalPrice().toStringAsFixed(2)}',
                        color: Colors.green,
                      ),
                      const SizedBox(height: 8),
                      TotalRow(
                        label: 'Total Eco Points:',
                        value: (cartController.calculateTotalEcoPoints() * 1.5)
                            .toString(),
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ],
              );
            }),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirm Order',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
