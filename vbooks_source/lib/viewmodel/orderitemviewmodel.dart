import 'package:flutter/material.dart';
import '../services/apiservice.dart';
import '../services/orderitemservice.dart';

class OrderItemViewModel extends ChangeNotifier {
  final OrderItemService orderItemService;
  bool _isLoading = false;
  String _errorMessage = '';

  OrderItemViewModel() : orderItemService = OrderItemService(ApiService());

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> addOrderItem({
    required String orderId,
    required String productId,
    required int quantity,
    required int unitPrice,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await orderItemService.addOrderItem(
        orderId: orderId,
        productId: productId,
        quantity: quantity,
        unitPrice: unitPrice,
      );
    } catch (e) {
      _errorMessage = 'Failed to add order item: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
