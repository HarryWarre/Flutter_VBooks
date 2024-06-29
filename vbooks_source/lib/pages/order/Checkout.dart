import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/order/Check_Your_Order.dart';

void main() {
  runApp(const MaterialApp(
    home: PaymentPage(),
  ));
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(21, 139, 125, 1)),
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước đó
          },
        ),
      ),
      
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StepWidget(
                  stepNumber: 1,
                  step: 'Giao hàng',
                  isCompleted: true,
                ),
                StepWidget(
                  stepNumber: 2,
                  step: 'Thanh toán',
                  isCompleted: true,
                ),
                StepWidget(
                  stepNumber: 3,
                  step: 'Kiểm tra',
                  isCompleted: false,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PaymentForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  final int stepNumber;
  final String step;
  final bool isCompleted;

  StepWidget(
      {required this.stepNumber, required this.step, this.isCompleted = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor:
              isCompleted ? Color.fromRGBO(21, 139, 125, 1) : Colors.grey,
          child: Text(
            stepNumber.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 5.0),
        Text(step),
      ],
    );
  }
}

class PaymentForm extends StatefulWidget {
  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'cash'; // Giá trị mặc định cho phương thức thanh toán
  String _selectedBank = ''; // Biến lưu trữ ngân hàng được chọn

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Xử lý logic khi form hợp lệ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thông tin thanh toán đã được gửi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Text(
            'Chọn phương thức thanh toán',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25.0),
          Text(
            'Bạn sẽ không thể mua hàng cho đến khi xem thông tin đơn hàng trong trang tiếp theo',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          RadioListTile<String>(
            title: const Text('Thanh toán tiền mặt'),
            value: 'cash',
            groupValue: _paymentMethod,
            onChanged: (value) {
              setState(() {
                _paymentMethod = value!;
              });
            },
            secondary: const Icon(Icons.attach_money), // Biểu tượng cho thanh toán tiền mặt
            activeColor: Color.fromRGBO(21, 139, 125, 1), // Set the active color
          ),
          RadioListTile<String>(
            title: const Text('Chuyển khoản'),
            value: 'bank_transfer',
            groupValue: _paymentMethod,
            onChanged: (value) {
              setState(() {
                _paymentMethod = value!;
              });
            },
            secondary: const Icon(Icons.account_balance), // Biểu tượng cho chuyển khoản
            activeColor: Color.fromRGBO(21, 139, 125, 1), // Set the active color
          ),
          if (_paymentMethod == 'bank_transfer') ...[
            const SizedBox(height: 16.0),
            Text(
              'Chọn ngân hàng:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Ngân hàng VietComBank'),
              leading: Radio<String>(
                value: 'Ngân hàng VietComBank',
                groupValue: _selectedBank,
                onChanged: (value) {
                  setState(() {
                    _selectedBank = value!;
                  });
                },
                activeColor: Color.fromRGBO(21, 139, 125, 1), // Set the active color
              ),
            ),
            ListTile(
              title: const Text('Ngân hàng Sacombank'),
              leading: Radio<String>(
                value: 'Ngân hàng Sacombank',
                groupValue: _selectedBank,
                onChanged: (value) {
                  setState(() {
                    _selectedBank = value!;
                  });
                },
                activeColor: Color.fromRGBO(21, 139, 125, 1), // Set the active color
              ),
            ),
            ListTile(
              title: const Text('Ngân hàng Techcombank'),
              leading: Radio<String>(
                value: 'Ngân hàng Techcombank',
                groupValue: _selectedBank,
                onChanged: (value) {
                  setState(() {
                    _selectedBank = value!;
                  });
                },
                activeColor: Color.fromRGBO(21, 139, 125, 1), // Set the active color
              ),
            ),
          ],
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrderReviewPage()),
                    );
                  },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Color.fromRGBO(21, 139, 125, 1),
            ),
            child: const Text(
              'Xác nhận thanh toán',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}