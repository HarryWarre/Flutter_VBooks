import 'package:flutter/material.dart';
import 'package:vbooks_source/data/model/typepaymentmodel.dart';
import 'package:vbooks_source/pages/order/checkyourorder.dart';
import '../../data/model/orderItem.dart';
import '../../services/apiservice.dart';
import '../../services/paymentservice.dart';

class PaymentForm extends StatefulWidget {
  final List<OrderItem> orderItems;

  PaymentForm({super.key, required this.orderItems});
  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'cash'; // Default payment method
  String _selectedBank = ''; // Variable to store selected bank
  late Future<List<TypePayment>> _paymentMethodsFuture;
  String? _paymentMethodName; // Variable to store payment method name

  @override
  void initState() {
    super.initState();
    // Initialize payment methods
    _paymentMethodsFuture =
        PaymentService(ApiService()).fetchPayments().then((paymentMethods) {
      if (paymentMethods.isNotEmpty) {
        // Đặt phương thức thanh toán đầu tiên làm giá trị mặc định
        setState(() {
          _paymentMethod = paymentMethods.first.id;
        });
      }
      return paymentMethods;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _paymentMethodName ??= await _getPaymentMethodName();
      if (_paymentMethodName == null)
        // Log order items
        for (var item in widget.orderItems) {
          print('Product ID: ${item.productId}, Quantity: ${item.quantity}');
        }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderReviewPage(
            paymentMethodId: _paymentMethod,
            paymentMethodName: _paymentMethodName!, // Use the fetched result
            orderItems: widget.orderItems, // Pass the orderItems list
          ),
        ),
      );
    }
  }

  Future<String> _getPaymentMethodName() async {
    final paymentService = PaymentService(ApiService());
    return await paymentService.fetchPaymentNameById(_paymentMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<TypePayment>>(
        future: _paymentMethodsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No payment methods available'));
          }

          final paymentMethods = snapshot.data!;

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  'Select Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25.0),
                Text(
                  'You will not be able to purchase until reviewing the order information on the next page',
                  style: TextStyle(fontSize: 18),
                ),
                ...paymentMethods.map((paymentMethod) {
                  return RadioListTile<String>(
                    title: Text(paymentMethod.name),
                    value: paymentMethod.id,
                    groupValue: _paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _paymentMethod = value!;
                      });
                    },
                    secondary: Icon(
                      Icons.payment,
                      // Icon for payment methods
                    ),
                    activeColor: Color.fromRGBO(21, 139, 125, 1),
                  );
                }).toList(),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: Color.fromRGBO(21, 139, 125, 1),
                  ),
                  child: const Text(
                    'Choose',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
