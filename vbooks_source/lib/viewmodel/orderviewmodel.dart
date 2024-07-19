import 'package:flutter/material.dart';
import '../services/apiservice.dart';
import '../services/orderservice.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderService orderService;
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = false;
  String _errorMessage = '';

  OrderViewModel() : orderService = OrderService(ApiService());

  Future<void> createOrder({
    required String userId,
    required String status,
    required String paymentMethodId,
    required double totalAmount,
  }) async {
    try {
      await orderService.createOrder(
        userId: userId,
        status: status,
        paymentMethodId: paymentMethodId,
        totalAmount: totalAmount,
      );
      // Handle success, e.g., show a success message or navigate to another page
    } catch (e) {
      print('Có lỗi đã xảy ra khi tạo đơn hàng: $e');
      // Handle error
    }
  }

  List<Map<String, dynamic>> get orders => _orders;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchOrders(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _orders = await orderService.fetchOrders(userId);
    } catch (e) {
      _errorMessage = 'Failed to load orders: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
