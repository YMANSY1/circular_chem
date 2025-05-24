import 'package:circular_chem_app/features/echo_points/widgets/eco_points_tracker.dart';
import 'package:circular_chem_app/features/marketplace/services/order_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/models/company.dart';

class YourEcoPointsScreen extends StatelessWidget {
  const YourEcoPointsScreen({super.key, required this.company});

  final Company company;

  @override
  Widget build(BuildContext context) {
    final future = OrderService(FirebaseFirestore.instance).getUserOrders();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Eco Point History'),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error Initializing leaderboard'));
          } else if (snapshot.hasData) {
            final orders = snapshot.data;
            if (orders == null || orders.isEmpty) {
              return Center(child: Text('Leaderboard is Empty'));
            } else {
              return EcoPointsTrackerWidget(orders: orders, company: company);
            }
          }
          return Center(child: Text('Leaderboard is Empty'));
        },
      ),
    );
  }
}
