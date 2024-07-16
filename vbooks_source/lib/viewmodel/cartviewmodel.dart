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

    try{
      await Future.delayed(Duration(milliseconds: 100));
      carts = await cartService.fetchCartsByAccountId(accountId);
    } catch (e) {
      print('Có lỗi đã xảy ra');
    } finally{
      isLoading = false;
      notifyListeners();
    }
  }
}