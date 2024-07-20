import 'dart:convert';
import 'package:vbooks_source/services/apiservice.dart';

class OrderService {
  final ApiService apiService;

  OrderService(this.apiService);

  Future<void> createOrder({
    required String userId,
    required String status,
    required String paymentMethodId,
    required double totalAmount,
  }) async {
    final response = await apiService.post(
      'order/add',
      {
        'userId': userId,
        'status': status,
        'paymentMethodId': paymentMethodId,
        'totalAmount': totalAmount,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create order');
    }
  }

  Future<List<Map<String, dynamic>>> fetchOrders(String userId) async {
    final response = await apiService.get('order/$userId');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return List<Map<String, dynamic>>.from(data['orders']);
      } else {
        throw Exception('Failed to load orders');
      }
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
