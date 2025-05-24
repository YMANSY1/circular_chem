import 'package:circular_chem_app/features/marketplace/widgets/sale_item_sliver_list.dart';
import 'package:flutter/material.dart';

import '../models/item.dart';

class ItemListFutureBuilder extends StatelessWidget {
  const ItemListFutureBuilder({
    super.key,
    required this.future,
  });

  final Future<List<Item>?> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(
              child: Text('Error retrieving data'),
            ),
          );
        } else if (snapshot.hasData) {
          final items = snapshot.data;
          if (items == null || items.isEmpty) {
            return SliverFillRemaining(
              child: Center(
                child: Text('No approved items found for sale'),
              ),
            );
          } else {
            return SaleItemsSliverList(items: items);
          }
        }
        return SliverFillRemaining(
          child: Center(
            child: Text('No approved items found for sale'),
          ),
        );
      },
    );
  }
}
