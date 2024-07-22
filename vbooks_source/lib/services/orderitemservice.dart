import 'package:vbooks_source/services/apiservice.dart';

class OrderItemService {
  final ApiService apiService;

  OrderItemService(this.apiService);

  Future<void> addOrderItem({
    required String orderId,
    required String productId,
    required int quantity,
    required int unitPrice,
  }) async {
    final response = await apiService.post(
      'orderdetail/add',
      {
        'orderId': orderId,
        'productId': productId,
        'quantity': quantity,
        'unitPrice': unitPrice,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add order item');
    }
  }
}
