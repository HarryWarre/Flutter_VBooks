import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vbooks_source/data/model/bookModel.dart';
import 'package:vbooks_source/pages/components/button.dart';
import 'package:vbooks_source/pages/components/widgetforscreen.dart';

class Detail extends StatefulWidget {
  final Book book;
  const Detail({Key? key, required this.book}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

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
                    child: Image.asset('assets/images${widget.book.img}'),
                  ),
                  const SizedBox(
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
                              '${widget.book.name}',
                              style: const TextStyle(
                                fontSize: 26,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: _toggleFavorite,
                              icon: Icon(
                                _isFavorite
                                    ? CupertinoIcons.heart_circle
                                    : CupertinoIcons.heart_circle_fill,
                                color: _isFavorite ? Colors.teal : Colors.grey,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              '${NumberFormat('###,###,###').format(widget.book.price)} Đ',
                              style: const TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
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
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AccountInfoRow(
                        label: 'Mã hàng:',
                        value: '${widget.book.id}',
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
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInfo(
                        label: 'Mô tả:',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.book.des}',
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const CartItemWidget(initialQuantity: 1),
                      Button(
                        width: 200,
                        height: 40,
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
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.teal,
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Icon(CupertinoIcons.cart),
      ),
    );
  }
}

class CartItemWidget extends StatefulWidget {
  final int initialQuantity;

  const CartItemWidget({
    Key? key,
    required this.initialQuantity,
  }) : super(key: key);

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

