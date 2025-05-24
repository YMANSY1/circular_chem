import 'package:circular_chem_app/features/echo_points/widgets/leaderboard_widget.dart';
import 'package:circular_chem_app/features/marketplace/services/marketplace_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EcoPointsLeaderboardScreen extends StatelessWidget {
  const EcoPointsLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final future =
        MarketplaceService(FirebaseFirestore.instance).getSellers(false);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error Initializing leaderboard'));
            } else if (snapshot.hasData) {
              final companies = snapshot.data;
              if (companies == null || companies.isEmpty) {
                return Center(child: Text('Leaderboard is Empty'));
              } else {
                return LeaderboardWidget(companies: companies);
              }
            }
            return Center(child: Text('Leaderboard is Empty'));
          },
        ),
      ),
    );
  }
}
