import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: OrderSuccessPage(),
  ));
}

class OrderSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mua hàng thành công',
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(21, 139, 125, 1)),
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước đó
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_circle, size: 150, color: Color.fromRGBO(21, 139, 125, 1)),
            SizedBox(height: 16.0),
            Text(
              'Cảm ơn quý khách!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Bạn đã đặt hàng thành công',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(21, 139, 125, 1), // Màu nền
              ),
              child: Text('Xem chi tiết đơn hàng', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(21, 139, 125, 1), // Màu nền
              ),
              child: Text('Quay về trang chủ', style: TextStyle(color: Colors.white)),
            ),
             SizedBox(height: 80.0),
          ],
          
        ),
        
      ),
      
    );
    
  }
}