import 'package:circular_chem_app/features/marketplace/models/category.dart';
import 'package:circular_chem_app/features/marketplace/models/seller.dart';

class Item {
  final String name;
  final Seller seller;
  final Category category;
  final double rating;
  final double price;

  Item(
    this.name,
    this.seller,
    this.category,
    this.rating,
    this.price,
  );
}
