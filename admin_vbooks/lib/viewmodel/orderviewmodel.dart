import 'package:admin_vbooks/services/apiservice.dart';
import 'package:flutter/material.dart';
import '../services/orderservice.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderService orderService;
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = false;
  String _errorMessage = '';

  OrderViewModel() : orderService = OrderService(ApiService());

  List<Map<String, dynamic>> get orders => _orders;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchAllOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _orders = await orderService.fetchAllOrders();
    } catch (e) {
      _errorMessage = 'Failed to load orders: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
