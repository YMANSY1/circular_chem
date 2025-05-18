import 'package:circular_chem_app/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/models/category_enum.dart';
import '../../../core/models/company.dart';

class Item {
  final String name;
  final Company sellingCompany;
  final CategoryType category;
  final double rating;
  final double price;
  final String? imageUrl;
  final int echoPoints;
  final int numberOfOrders;
  final bool isApproved;
  final String? description;
  final int quantity; // Added quantity here.

//<editor-fold desc="Data Methods">
  const Item({
    required this.name,
    required this.sellingCompany,
    required this.category,
    this.rating = 0,
    required this.price,
    this.echoPoints = 0,
    this.numberOfOrders = 0,
    this.imageUrl,
    this.isApproved = false,
    this.description,
    required this.quantity, // Added quantity here.
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          sellingCompany == other.sellingCompany &&
          category == other.category &&
          rating == other.rating &&
          price == other.price &&
          imageUrl == other.imageUrl &&
          echoPoints == other.echoPoints &&
          numberOfOrders == other.numberOfOrders &&
          isApproved == other.isApproved &&
          description == other.description &&
          quantity == other.quantity); // Added quantity to comparison

  @override
  int get hashCode =>
      name.hashCode ^
      sellingCompany.hashCode ^
      category.hashCode ^
      rating.hashCode ^
      price.hashCode ^
      imageUrl.hashCode ^
      echoPoints.hashCode ^
      numberOfOrders.hashCode ^
      isApproved.hashCode ^
      description.hashCode ^
      quantity.hashCode; // Added quantity

  @override
  String toString() {
    return 'Item{' +
        ' name: $name,' +
        ' seller: $sellingCompany,' +
        ' category: $category,' +
        ' rating: $rating,' +
        ' price: $price,' +
        ' imageUrl: $imageUrl,' +
        ' description: $description,' + // Added description
        ' quantity: $quantity,' + // Added quantity
        '}';
  }

  Item copyWith({
    String? name,
    Company? seller,
    CategoryType? category,
    double? rating,
    double? price,
    String? imageUrl,
    int? echoPoints,
    int? numberOfOrders,
    bool? isApproved,
    String? description,
    int? quantity, // Added quantity
  }) {
    return Item(
      name: name ?? this.name,
      sellingCompany: seller ?? sellingCompany,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      echoPoints: echoPoints ?? this.echoPoints,
      numberOfOrders: numberOfOrders ?? this.numberOfOrders,
      isApproved: isApproved ?? this.isApproved,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity, // Added quantity
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sellerId': FirebaseAuth.instance.currentUser!.uid,
      'category': category.name,
      'rating': rating,
      'price': price,
      'imageUrl': imageUrl,
      'echoPoints': echoPoints,
      'numberOfOrders': numberOfOrders,
      'isApproved': isApproved,
      'description': description,
      'quantity': quantity, // Added quantity
    };
  }

  static Future<Item> fromMap(Map<String, dynamic> map) async {
    return Item(
      name: map['name'] as String,
      sellingCompany: await AuthService(FirebaseAuth.instance)
          .getCompanyData(map['sellerId']) as Company,
      category: CategoryType.fromString(map['category']),
      rating: map['rating'] as double,
      price: map['price'] as double,
      imageUrl: map['imageUrl'] as String,
      echoPoints: map['echoPoints'] as int,
      numberOfOrders: map['numberOfOrders'] as int,
      isApproved: map['isApproved'] as bool,
      description: map['description'] as String,
      quantity: map['quantity'] as int, // Added quantity
    );
  }
//</editor-fold>
}
