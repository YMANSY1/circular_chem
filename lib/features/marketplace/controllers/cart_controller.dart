import 'package:get/get.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  final cart = Cart();

  // Create reactive versions for UI updates
  final _cartItems = <CartItem>[].obs;
  final _totalItems = 0.obs;

  RxList<CartItem> get cartItems => _cartItems;
  int get totalItems => _totalItems.value;

  @override
  void onInit() {
    super.onInit();
    _updateReactiveCart();
  }

  void addToCart(CartItem item) {
    cart.addToCart(item);
    _updateReactiveCart();
  }

  void removeFromCart(CartItem item) {
    cart.removeFromCart(item);
    _updateReactiveCart();
  }

  void incrementQuantity(CartItem item) {
    if (item.quantity >= item.item.quantity) {
      return;
    }
    item.incrementQuantity();
    _updateReactiveCart();
  }

  void decrementQuantity(CartItem item) {
    item.decrementQuantity();
    _updateReactiveCart();
  }

  void clearCart() {
    cart.clearCart();
    _updateReactiveCart();
  }

  void _updateReactiveCart() {
    _cartItems.value = List.from(cart.cart);
    _totalItems.value = cart.cart.length;
  }

  double calculateTotal() {
    return cartItems.fold(
        0.0, (total, item) => total + (item.item.price * item.quantity));
  }

  int calculateTotalEcoPoints() {
    return cartItems.fold(
      0,
      (total, item) => total + (item.item.ecoPoints * item.quantity),
    );
  }
}
