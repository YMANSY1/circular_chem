import 'package:circular_chem_app/core/models/category_enum.dart';
import 'package:circular_chem_app/features/marketplace/services/marketplace_service.dart';
import 'package:circular_chem_app/features/marketplace/widgets/item_list_future_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.category});

  final CategoryType category;

  @override
  Widget build(BuildContext context) {
    final future = MarketplaceService(FirebaseFirestore.instance)
        .getApprovedItems(category: category);
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: CustomScrollView(
        slivers: [
          ItemListFutureBuilder(future: future),
        ],
      ),
    );
  }
}
