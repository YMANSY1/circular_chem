import 'package:circular_chem_app/core/models/category_enum.dart';
import 'package:circular_chem_app/features/marketplace/services/marketplace_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/models/company.dart';
import '../models/category.dart';
import '../models/item.dart';
import '../widgets/category_list_view.dart';
import '../widgets/featured_seller_list_view.dart';
import '../widgets/icon_text.dart';
import '../widgets/item_list_future_builder.dart';

class MarketplacePage extends StatelessWidget {
  MarketplacePage({super.key});

  final categories = <Category>[
    Category(
      CategoryType.metalMaterials.name,
      'assets/images/metal_materials.jpg',
    ),
    Category(
      CategoryType.plasticComponents.name,
      'assets/images/plastic_components.jpg',
    ),
    Category(
      CategoryType.textilesFabrics.name,
      'assets/images/textiles_fabrics.jpg',
    ),
    Category(
      CategoryType.woodSawdust.name,
      'assets/images/wood_sawdust.jpg',
    ),
    Category(
      CategoryType.chemicalByproducts.name,
      'assets/images/chemical_byproducts.jpg',
    ),
    Category(
      CategoryType.rubberElastomers.name,
      'assets/images/rubber_elastomers.jpg',
    ),
  ];

  final featuredSellers = <Company>[];

  List<Item> get items => [];

  final itemsFuture =
      MarketplaceService(FirebaseFirestore.instance).getApprovedItems();

  final featuredSellersFuture =
      MarketplaceService(FirebaseFirestore.instance).getSellers(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: IconText(
              text: 'Categories',
              icon: Icons.category_sharp,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: CategoryListView(categories: categories),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: IconText(
                text: 'Featured Sellers',
                icon: Icons.factory,
              ),
            ),
          ),
          FutureBuilder(
            future: featuredSellersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                SliverFillRemaining(
                  child: Center(
                    child: Text('Error getting featured sellers'),
                  ),
                );
              } else if (snapshot.hasData) {
                final featuredSellers = snapshot.data;
                if (featuredSellers == null || featuredSellers.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text('No featured sellers found'),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: FeaturedSellerListView(
                        featuredSellers: featuredSellers),
                  );
                }
              }
              return SliverFillRemaining(
                child: Center(
                  child: Text('No featured sellers found'),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: IconText(
                text: 'Have a Browse!',
                icon: Icons.shopping_basket_rounded,
              ),
            ),
          ),
          ItemListFutureBuilder(future: itemsFuture)
        ],
      ),
    );
  }
}
