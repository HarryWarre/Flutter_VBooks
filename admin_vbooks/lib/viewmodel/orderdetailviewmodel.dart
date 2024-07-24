import 'package:flutter/material.dart';
import '../services/apiservice.dart';
import '../services/orderdetailservice.dart';

class OrderDetailViewModel extends ChangeNotifier {
  final OrderDetailService orderDetailService;
  List<Map<String, dynamic>> _orderDetails = [];
  bool _isLoading = false;
  String _errorMessage = '';

  OrderDetailViewModel() : orderDetailService = OrderDetailService(ApiService());

  List<Map<String, dynamic>> get orderDetails => _orderDetails;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchOrderDetails(String orderId) async {
    _isLoading = true;
    Future.microtask(() => notifyListeners());


    try {
      var orderDetails = await orderDetailService.fetchOrderDetails(orderId);
    _orderDetails = orderDetails.map((orderDetail) {
      return {
        'productName': orderDetail['productId']['name'] ?? 'N/A',
        'productImage': orderDetail['productId']['image'] ?? 'N/A',
        'price': orderDetail['productId']['price'] ?? 0,
        'quantity': orderDetail['quantity'] ?? 0,
      };
    }).toList();
    } catch (e) {
      _errorMessage = 'Failed to load order details: $e';
    } finally {
      _isLoading = false;
      Future.microtask(() => notifyListeners());
    }
  }
}
