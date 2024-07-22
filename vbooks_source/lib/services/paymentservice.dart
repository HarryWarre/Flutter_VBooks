import 'dart:convert';
import 'package:vbooks_source/data/model/typepaymentmodel.dart';
import './apiservice.dart';

class PaymentService {
  final ApiService apiService;

  PaymentService(this.apiService);

  Future<List<TypePayment>> fetchPayments() async {
    final response = await apiService.get('payment/getPayment');

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TypePayment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load payments');
    }
  }

  Future<String> fetchPaymentNameById(String paymentId) async {
    final payments = await fetchPayments();
    final payment = payments.firstWhere(
      (p) => p.id == paymentId,
      orElse: () => throw Exception('Payment method not found'),
    );
    return payment.name;
  }
}
