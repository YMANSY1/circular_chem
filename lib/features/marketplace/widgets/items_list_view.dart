import 'package:flutter/material.dart';

import '../models/item.dart';
import 'marketplace_item_card.dart';

class ItemsListView extends StatelessWidget {
  const ItemsListView({
    super.key,
    required this.items,
  });

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) =>
          MarketplaceItemCard(item: items[index]),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 8),
    );
  }
}
