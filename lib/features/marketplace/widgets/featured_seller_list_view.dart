import 'package:flutter/material.dart';

import '../models/seller.dart';
import 'featured_seller_card.dart';

class FeaturedSellerListView extends StatelessWidget {
  const FeaturedSellerListView({
    super.key,
    required this.featuredSellers,
  });

  final List<Seller> featuredSellers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 114,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final featuredSeller = featuredSellers[index];
          return FeaturedSellerCard(featuredSeller: featuredSeller);
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 12),
        itemCount: featuredSellers.length,
      ),
    );
  }
}
