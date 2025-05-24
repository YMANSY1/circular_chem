import 'package:flutter/material.dart';

import '../models/item.dart';
import 'item_expansion_tile.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({
    super.key,
    required this.items,
    required this.onPointsUpdated,
  });

  final List<Item> items;
  final VoidCallback onPointsUpdated;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return ItemExpansionTile(
          title: Text('Order'),
          detailTiles: [],
        );
      },
    );
  }
}
