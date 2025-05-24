import 'item.dart';

class CartItem {
  final Item item;
  int _quantity;

  int get quantity => _quantity;

  void incrementQuantity() => _quantity++;

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
    }
  }

//<editor-fold desc="Data Methods">
  CartItem({
    required this.item,
    int quantity = 1,
  }) : _quantity = quantity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItem &&
          runtimeType == other.runtimeType &&
          item == other.item &&
          _quantity == other._quantity);

  @override
  int get hashCode => item.hashCode ^ _quantity.hashCode;

  @override
  String toString() {
    return 'CartItem{' + ' item: $item,' + ' _quantity: $_quantity,' + '}';
  }

  CartItem copyWith({
    Item? item,
    int? quantity,
  }) {
    return CartItem(
      item: item ?? this.item,
      quantity: quantity ?? this._quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item': this.item.toMap(),
      'quantity': this._quantity, // Changed from '_quantity' to 'quantity'
    };
  }

  // FIX: Make this static and properly handle async
  static Future<CartItem> fromMap(Map<String, dynamic> map) async {
    return CartItem(
      item: await Item.fromMap(map['item'] as Map<String, dynamic>),
      quantity:
          map['quantity'] as int, // Changed from '_quantity' to 'quantity'
    );
  }

//</editor-fold>
}
