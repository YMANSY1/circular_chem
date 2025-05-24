import 'package:circular_chem_app/core/models/category_enum.dart';
import 'package:circular_chem_app/features/marketplace/screens/category_page.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) =>
              CategoryPage(category: CategoryType.fromString(category.name)))),
      child: Container(
        width: 200,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(category.imagePath),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Text(
            category.name,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
