import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vbooks_source/data/model/bookModel.dart';
import 'package:vbooks_source/pages/account/detailbook.dart';
import 'package:vbooks_source/pages/components/button.dart';
import 'package:vbooks_source/pages/components/widgetforscreen.dart';

class Detail extends StatelessWidget {
  final Book book;
  const Detail({super.key,required this.book});
  

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
                    child: Image.asset('assets/images${book.img}'),
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
                              '${book.name}',
                              style: const TextStyle(
                                fontSize: 26,
                              ),
                            ),
                            const Spacer(), // Đẩy IconButton ra ngoài rìa phải
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.heart_circle_fill,
                                color: Colors.red,
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
                              '${NumberFormat('###,###,###').format(book.price)} Đ',
                              style:  const TextStyle(
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
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AccountInfoRow(
                        label: 'Mã hàng:',
                        value: '${book.id}',
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
                              '${book.des}',
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
    );
  }
}