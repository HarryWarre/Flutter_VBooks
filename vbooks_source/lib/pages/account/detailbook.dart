import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vbooks_source/pages/components/button.dart';
import 'package:vbooks_source/pages/components/widgetforscreen.dart';

class DetailBookScreen extends StatefulWidget {
  const DetailBookScreen({super.key});

  @override
  State<DetailBookScreen> createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  Container(
                    height: 260,
                    alignment: Alignment.center,
                    child: Image.asset('assets/spy.png'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Spy x Family',
                              style: TextStyle(
                                fontSize: 26,
                              ),
                            ),
                            Spacer(), // Đẩy IconButton ra ngoài rìa phải
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                CupertinoIcons.heart_circle_fill,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              '40.000 VNĐ',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                                width: 40), // Khoảng cách giữa hai đoạn văn bản
                            Text(
                              '45.000 VNĐ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomDivider(
              height: 12,
              color: Colors.grey[300],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextInfo(
                        label: 'Thông tin sản phẩm',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AccountInfoRow(
                        label: 'Mã hàng:',
                        value: '#123456789',
                        style: TextStyle(fontSize: 16),
                        width: 150,
                      ),
                      AccountInfoRow(
                        label: 'Nhà cung cấp:',
                        value: 'Công ty xxx',
                        style: TextStyle(fontSize: 16),
                        width: 150,
                      ),
                      AccountInfoRow(
                        label: 'Nhà xuất bản:',
                        value: 'Kim Đồng',
                        style: TextStyle(fontSize: 16),
                        width: 150,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInfo(
                        label: 'Mô tả:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vì những lý do riêng, một điệp viên, một sát thủ và một nhà ngoại cảm bắt tay đóng giả làm một gia đình trong khi che giấu danh tính thật của họ với nhau.',
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CartItemWidget(initialQuantity: 1),
                      Button(
                        width: 200,
                        height: 30,
                        text: 'Mua Ngay',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextInfo extends StatelessWidget {
  final String label;
  final TextStyle? style;

  TextInfo({Key? key, required this.label, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style,
    );
  }
}

class CartItemWidget extends StatefulWidget {
  final int initialQuantity;

  const CartItemWidget({
    super.key,
    required this.initialQuantity,
  });

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _decrementQuantity,
          ),
          Text('$quantity',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _incrementQuantity,
          ),
        ],
      ),
    );
  }
}
