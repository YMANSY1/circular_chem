import 'cart_item.dart';

class Cart {
  static final Cart _instance = Cart._internal();

  Cart._internal();

  factory Cart() => _instance;

  static final _cart = <CartItem>[];

  List<CartItem> get cart => List.unmodifiable(_cart);

  void addToCart(CartItem item) => _cart.add(item);

  void removeFromCart(CartItem item) => _cart.remove(item);

  void clearCart() => _cart.clear();
}
