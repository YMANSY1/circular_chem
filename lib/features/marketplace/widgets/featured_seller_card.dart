import 'package:flutter/material.dart';

import '../../../core/models/company.dart';

class FeaturedSellerCard extends StatelessWidget {
  const FeaturedSellerCard({
    super.key,
    required this.featuredSeller,
  });

  final Company featuredSeller;

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
              image: NetworkImage(featuredSeller.profilePicUrl!),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(featuredSeller.companyName),
        )
      ],
    );
  }
}
