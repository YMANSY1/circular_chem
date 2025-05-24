import 'package:circular_chem_app/features/marketplace/screens/add_item_screen.dart';
import 'package:circular_chem_app/features/marketplace/services/marketplace_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/add_item_button.dart';
import '../widgets/items_list_view.dart';

class UserItemsScreen extends StatelessWidget {
  const UserItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final future =
        MarketplaceService(FirebaseFirestore.instance).getUserItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Items'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AddItemButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddItemScreen())),
            ),
          ),
          FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                    child: const Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Expanded(
                  child: const Center(
                      child: Text('Error finding your item postings')),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Expanded(
                      child: Center(child: const Text('No items found.')));
                } else {
                  final items = snapshot.data!;
                  return ItemsListView(items: items);
                }
              } else {
                return Expanded(
                    child: const Center(child: Text('No items found.')));
              }
            },
          )
        ],
      ),
    );
  }
}
