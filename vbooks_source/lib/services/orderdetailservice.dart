import 'dart:convert';
import 'package:vbooks_source/services/apiservice.dart';

class OrderDetailService {
  final ApiService apiService;

  OrderDetailService(this.apiService);

  Future<List<Map<String, dynamic>>> fetchOrderDetails(String orderId) async {
    final response = await apiService.get('orderdetail/$orderId');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return List<Map<String, dynamic>>.from(data['orderDetails']);
      } else {
        throw Exception('Failed to load order details');
      }
    } else {
      throw Exception('Failed to load order details');
    }
  }
}

