import 'package:flutter/material.dart';

import '../data/model/cartmodel.dart';
import '../services/apiservice.dart';
import '../services/cartservice.dart';

class CartViewModel extends ChangeNotifier {
  List<Cart> carts = [];
  bool isLoading = false;
  final CartService cartService;

  CartViewModel() : cartService = CartService(ApiService());

  Future<void> fetchCartByIdAccount(String accountId) async {
    isLoading = true;
    // notifyListeners();

    try {
      await Future.delayed(Duration(milliseconds: 100));
      carts = await cartService.fetchCartsByAccountId(accountId);
      print('API: + ${carts.length}');
    } catch (e) {
      print('Có lỗi đã xảy ra');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCartItemQuantity(String cartItemId, int quantity) async {
    try {
      await cartService.updateCartItemQuantity(cartItemId, quantity);
      // Cập nhật số lượng trong danh sách giỏ hàng
      var cartItem = carts.firstWhere((item) => item.id == cartItemId);
      cartItem.quantity = quantity;
      notifyListeners();
    } catch (e) {
      print('Có lỗi đã xảy ra');
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      await cartService.deleteCartItem(cartItemId);
      // Xóa item khỏi danh sách giỏ hàng
      carts.removeWhere((item) => item.id == cartItemId);
      notifyListeners();
    } catch (e) {
      print('Có lỗi đã xảy ra');
    }
  }

  Future<void> addCartItem(
      String accountId, String productId, int quantity) async {
    try {
      // Fetch current cart items
      await fetchCartByIdAccount(accountId);

      // Kiểm tra xem sản phẩm có tồn tại trong giỏ hàng không
      bool productExists = carts.any((item) => item.productId == productId);

      if (productExists) {
        // Nếu sản phẩm đã tồn tại, lấy nó và cập nhật số lượng
        var existingCartItem = carts.firstWhere(
          (item) => item.productId == productId,
        );
        await cartService.updateCartItemQuantity(
          existingCartItem.id!,
          existingCartItem.quantity! + quantity,
        );
      } else {
        // Nếu sản phẩm không tồn tại, thêm mới vào giỏ hàng
        await cartService.addCartItem(accountId, productId, quantity);
      }

      // Làm mới giỏ hàng sau khi thêm/cập nhật
      await fetchCartByIdAccount(accountId);
    } catch (e) {
      print('Có lỗi đã xảy ra: $e');
    }
  }
}
