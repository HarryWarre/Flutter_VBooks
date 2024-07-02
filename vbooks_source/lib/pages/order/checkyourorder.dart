import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/order/successfulpurchase.dart';

void main() {
  runApp(const MaterialApp(
    home: OrderReviewPage(),
  ));
}

class OrderReviewPage extends StatelessWidget {
  const OrderReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kiểm tra đơn hàng'),
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
                  isCompleted: true,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: OrderReviewForm(),
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

class OrderReviewForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Thông tin giao hàng',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListTile(
          title: Text('Họ và tên: Ngô Trung Đạt'),
          subtitle: Text('Địa chỉ: Hai Bà Trưng, Quận 1, TP.HCM'),
        ),
        ListTile(
          title: Text('Số điện thoại: 0123456789'),
          subtitle: Text('Email: siucr7@gmail.com'),
        ),
        SizedBox(height: 16.0),
        Text(
          'Phương thức thanh toán',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListTile(
          title: Text('Thanh toán tiền mặt'),
        ),
        SizedBox(height: 16.0),
        Text(
          'Danh sách mặt hàng',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        ListTile(
          leading: Image.network(
              'https://bizweb.dktcdn.net/thumb/large/100/197/269/products/tam-ly-hoc-thanh-cong-304x472.jpg?v=1516592128997',
              width: 35,
              height: 55,
              fit: BoxFit.cover),
          title: Text('Red Queen'),
          trailing: Text('x1'),
        ),
        SizedBox(height: 16.0),
        ListTile(
          leading: Image.network(
              'https://static.oreka.vn/800-800_0fa33f3c-4354-4a55-ad59-868547814f67',
              width: 35,
              height: 55,
              fit: BoxFit.cover),
          title: Text('To Kill A Mockingbird'),
          trailing: Text('x2'),
        ),
        SizedBox(height: 16.0),
        ListTile(
          leading: Image.network(
              'https://www.elleman.vn/wp-content/uploads/2019/12/05/cho-sua-nham-cay-sach-tam-ly-elleman-1119-Vidoda.jpg',
              width: 35,
              height: 55,
              fit: BoxFit.cover),
          title: Text('How to Drink'),
          trailing: Text('x1'),
        ),
        SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderSuccessPage()),
                    );
                  },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(fontSize: 20),
            backgroundColor: Color.fromRGBO(21, 139, 125, 1),
          ),
          child: const Text(
            'Xác nhận đơn hàng',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}