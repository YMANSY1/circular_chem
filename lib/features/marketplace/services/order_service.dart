import 'package:circular_chem_app/features/marketplace/controllers/cart_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/cart.dart';
import '../models/order.dart' as orderModel;

class OrderService {
  final _currentUser = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore firebaseFirestore;
  final _cart = Cart().cart;
  final _cartController = Get.put(CartController());

  OrderService(this.firebaseFirestore);

  Future<void> createOrder() async {
    final totalEcoPoints = _cartController.calculateTotalEcoPoints();

    final batch = firebaseFirestore.batch();

    final userRef = firebaseFirestore.collection('users').doc(_currentUser.uid);

    batch.update(
      userRef,
      {
        'echo_points': FieldValue.increment((totalEcoPoints * 1.5).round()),
      },
    );

    for (final cartItem in _cart) {
      final item = cartItem.item;

      final sellerRef =
          firebaseFirestore.collection('users').doc(item.sellingCompany.id);

      batch.update(
        sellerRef,
        {
          'echo_points':
              FieldValue.increment(item.ecoPoints * cartItem.quantity),
        },
      );
    }

    final orderRef = firebaseFirestore.collection('orders').doc();

    final order = orderModel.Order(
      id: orderRef.id,
      customerId: _currentUser.uid,
      items: _cart,
      totalPrice: _cartController.calculateTotal(),
      orderDate: DateTime.now(),
    );

    batch.set(orderRef, order.toMap());

    await batch.commit();
  }

  Future<List<orderModel.Order>> getUserOrders() async {
    try {
      final orderRef = await firebaseFirestore
          .collection('orders')
          .where('customerId', isEqualTo: _currentUser.uid)
          .get();

      final docs = orderRef.docs;

      final orders = await Future.wait(
          docs.map((doc) => orderModel.Order.fromMap(doc.data(), id: doc.id)));

      return orders;
    } catch (e) {
      print('Error getting user orders: $e');
      rethrow;
    }
  }
}
