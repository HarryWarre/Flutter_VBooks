import 'dart:convert';
import 'package:admin_vbooks/services/apiservice.dart';

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

  Future<List<Map<String, dynamic>>> fetchAllOrders() async {
    final response = await apiService.get('order/all');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return List<Map<String, dynamic>>.from(data['orders'].map((order) {
          return {
            'idDonHang': order['_id'] ?? '',
            'nguoiDat': order['userId']?['fullName'] ?? '',
            'status': order['status'] ?? '',
            'paymentMethodId': order['paymentMethodId']?['name'] ?? '',
            'totalAmount': order['totalAmount']?.toString() ?? '0',
            'orderDate': order['orderDate'] ?? '',
            'address': order['userId']?['address'] ?? '',
            'phoneNumber': order['userId']?['phoneNumber'] ?? '',
          };
        }));
      } else {
        throw Exception('Failed to load orders');
      }
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    final response = await apiService.put(
      'order/update/$orderId',
      {'status': status},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update order status');
    }
  }
}
