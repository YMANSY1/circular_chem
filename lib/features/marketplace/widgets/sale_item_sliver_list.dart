import 'package:flutter/material.dart';

import '../models/item.dart';
import 'marketplace_item_card.dart';

class SaleItemsSliverList extends StatelessWidget {
  const SaleItemsSliverList({
    super.key,
    required this.items,
  });

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return MarketplaceItemCard(item: items[index]);
      },
      separatorBuilder: (_, __) => SizedBox(height: 1),
    );
  }
}
