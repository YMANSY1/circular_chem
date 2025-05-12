import 'package:flutter/material.dart';

import '../models/seller.dart';

class FeaturedSellerCard extends StatelessWidget {
  const FeaturedSellerCard({
    super.key,
    required this.featuredSeller,
  });

  final Seller featuredSeller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.lightBlue,
            image: DecorationImage(
              image: NetworkImage(featuredSeller.imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(featuredSeller.name),
        )
      ],
    );
  }
}
