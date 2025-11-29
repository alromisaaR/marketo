import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../data/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final Box<CartItem> cartBox;

  CartCubit(this.cartBox) : super(CartInitial()) {

    loadCart();
  }

  /// Load all cart items initially
  Future<void> loadCart() async {
    await Future.delayed(const Duration(seconds: 1)).then((e){
      var items = cartBox.values.toList();
      emit(CartLoaded(items));
    });

  }
  Future<void> updateQuantity(int productId, int quantity) async {

    if (!cartBox.containsKey(productId)) return;
    final item = cartBox.get(productId)!;
    item.quantity = quantity;
    await item.save();
    final items = cartBox.values.toList();
    emit(CartLoaded(items));
  }
  /// Add or update an item in the cart
  Future<void> addToCart(CartItem item) async {
    emit(CartInitial());
    if (cartBox.containsKey(item.productId)) {
      // Update existing
      final existing = cartBox.get(item.productId)!;
      existing.quantity += item.quantity;
      await existing.save();
    } else {
      // Add new item
      await cartBox.put(item.productId, item);
    }

    //  Force rebuild by reloading list
    final items = cartBox.values.toList();
    emit(CartLoaded(items));
  }

  /// Remove one item
  Future<void> removeFromCart(int productId) async {
    await cartBox.delete(productId);
    emit(CartLoaded(cartBox.values.toList()));
  }

  /// Clear all items
  Future<void> clearCart() async {
    await cartBox.clear();
    emit(CartLoaded([]));
  }

  /// Refresh manually if needed
  void refresh() {
    emit(CartLoaded(cartBox.values.toList()));
  }

  /// Get current total
  double get total {
    return cartBox.values.fold(
      0,
          (sum, item) => sum + (item.price * item.quantity),
    );
  }
}