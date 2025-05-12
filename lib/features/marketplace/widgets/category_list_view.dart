import 'package:flutter/material.dart';

import '../models/category.dart';
import 'category_card.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final category = categories[index];
        return CategoryCard(category: category);
      },
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        width: 8,
      ),
    );
  }
}
