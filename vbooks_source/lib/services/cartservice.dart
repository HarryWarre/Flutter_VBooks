import 'dart:convert';
import 'package:vbooks_source/data/model/cartmodel.dart';
import 'apiservice.dart';

class CartService {
  final ApiService apiService;

  CartService(this.apiService);

  Future<List<Cart>> fetchCartsByAccountId(String accountId) async {
    final response = await apiService.get('cart/$accountId');
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> data = jsonResponse['carts'];
      return data.map((json) => Cart.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> updateCartItemQuantity(String cartItemId, int quantity) async {
    final response = await apiService.patch(
      'cart/edit/$cartItemId',
      {'quantity': quantity},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart item quantity');
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    final response = await apiService.delete('cart/delete/$cartItemId');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete cart item');
    }
  }

  Future<void> addCartItem(
      String accountId, String productId, int quantity) async {
    final response = await apiService.post(
      'cart/add',
      {
        'accountId': accountId,
        'productId': productId,
        'quantity': quantity,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add item to cart');
    }
  }
}
