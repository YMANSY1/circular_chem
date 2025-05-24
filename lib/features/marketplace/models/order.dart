import 'package:circular_chem_app/features/marketplace/models/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String customerId;
  final List<CartItem> items;
  final double totalPrice;
  final bool isDelivered;
  final DateTime orderDate;

//<editor-fold desc="Data Methods">
  const Order({
    required this.id,
    required this.customerId,
    required this.items,
    required this.totalPrice,
    this.isDelivered = false,
    required this.orderDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          customerId == other.customerId &&
          items == other.items &&
          totalPrice == other.totalPrice &&
          isDelivered == other.isDelivered &&
          orderDate == other.orderDate);

  @override
  int get hashCode =>
      id.hashCode ^
      customerId.hashCode ^
      items.hashCode ^
      totalPrice.hashCode ^
      isDelivered.hashCode ^
      orderDate.hashCode;

  @override
  String toString() {
    return 'Order{' +
        ' id: $id,' +
        ' customerId: $customerId,' +
        ' items: $items,' +
        ' totalPrice: $totalPrice,' +
        ' isDelivered: $isDelivered,' +
        ' orderDate: $orderDate,' +
        '}';
  }

  Order copyWith({
    String? id,
    String? sellerId,
    String? customerId,
    List<CartItem>? items,
    double? totalPrice,
    bool? isDelivered,
    DateTime? orderDate,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      isDelivered: isDelivered ?? this.isDelivered,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalPrice': totalPrice,
      'isDelivered': isDelivered,
      'orderDate': Timestamp.fromDate(orderDate),
    };
  }

  // FIX: Make this async and properly handle the async CartItem.fromMap calls
  static Future<Order> fromMap(Map<String, dynamic> map,
      {required String id}) async {
    // Convert all cart items asynchronously
    final List<CartItem> items = [];
    for (final itemMap in map['items'] as List<dynamic>) {
      final cartItem = await CartItem.fromMap(itemMap as Map<String, dynamic>);
      items.add(cartItem);
    }

    return Order(
      id: id,
      customerId: map['customerId'] as String,
      items: items,
      totalPrice: (map['totalPrice'] as num).toDouble(),
      isDelivered: map['isDelivered'] as bool,
      orderDate: (map['orderDate'] as Timestamp).toDate(),
    );
  }

  // FIX: Make this async too
  static Future<Order> fromDocumentSnapshot(DocumentSnapshot doc) async {
    return await Order.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
  }

//</editor-fold>
}
