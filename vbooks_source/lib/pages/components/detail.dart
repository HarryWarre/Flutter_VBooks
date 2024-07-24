import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/conf/const.dart';
import 'package:vbooks_source/data/model/productmodel.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/pages/components/button.dart';
import 'package:vbooks_source/pages/components/scafformessenger.dart';
import 'package:vbooks_source/pages/components/widgetforscreen.dart';
import 'package:vbooks_source/services/apiservice.dart';
import 'package:vbooks_source/services/cartservice.dart';
import 'package:vbooks_source/services/favoriteservice.dart'; // Import FavoriteService

import '../../data/model/orderItem.dart';
import '../../viewmodel/cartviewmodel.dart';
import '../order/Checkout.dart';
import '../order/deliveryinformation.dart';
import '../order/orderdetailpage.dart';
import '../order/ordermainpage.dart';

class Detail extends StatefulWidget {
  final Product book;
  const Detail({Key? key, required this.book}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool _isFavorite = false;
  String token = '';
  String _id = '';
  late ApiService _apiService;
  late final CartViewModel cartViewModel;
  late CartService _cartService;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _cartService = CartService(_apiService);
    cartViewModel = CartViewModel(); // Khởi tạo CartViewModel
    _loadToken();
  }

  Future<void> addItemToCart() async {
    if (token != '' && _id != '') {
      var response =
          await cartViewModel.addCartItem(_id, widget.book.id!, _quantity);
      if (true) {
        _showSnackbar();
      } else {
        // Handle error
      }
    }
  }

  void _buyNow() {
    // Create a list with one OrderItem
    List<OrderItem> orderItems = [
      OrderItem(
        productId: widget.book.id!,
        quantity: _quantity,
      ),
    ];

    // Navigate to the PaymentForm
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentForm(orderItems: orderItems),
      ),
    );
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    if (storedToken != null && storedToken.isNotEmpty) {
      if (JwtDecoder.isExpired(storedToken)) {
        setState(() {
          token = 'Invalid token';
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ));
      } else {
        setState(() {
          token = storedToken;
          Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
          _id = jwtDecodedToken['_id'] ?? '...';
          _checkIfFavorite(); // Gọi sau khi tải token
        });
      }
    } else {
      setState(() {
        token = 'Invalid token';
      });
    }
  }

  Future<void> _checkIfFavorite() async {
    if (widget.book.id != null) {
      _isFavorite =
          await FavoriteService(ApiService()).isFavorite(_id, widget.book.id!);
      setState(() {});
    } else {
      print('Product ID is null');
    }
  }

  Future<void> _toggleFavorite() async {
    if (widget.book.id != null) {
      if (_isFavorite) {
        print(widget.book.id!);
        await FavoriteService(ApiService())
            .deleteFavorite(_id, widget.book.id!);
      } else {
        await FavoriteService(ApiService()).addFavorite(_id, widget.book.id!);
      }
      setState(() {
        _isFavorite = !_isFavorite;
      });
    } else {
      print('Product ID is null');
    }
  }

  void _showSnackbar() {
    const snackBar = SnackBar(
      content: Text(
        'Đã thêm sản phẩm vào giỏ hàng',
        style: TextStyle(color: Color.fromARGB(255, 8, 7, 7)), // Text color
      ),
      backgroundColor: Colors.white, // Background color
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
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
                      child: Image.asset(
                        'assets/images/product/${widget.book.img}' ??
                            '', // Đảm bảo rằng đây là URL hợp lệ
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 260,
                            color: Colors.white,
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  '${widget.book.name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 26,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: _toggleFavorite,
                                icon: Icon(
                                  _isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      _isFavorite ? Colors.teal : Colors.grey,
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
                              const SizedBox(
                                width: 40,
                              ),
                              const Text(
                                '45.000 VNĐ', // oldprice
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
                height: 1,
                color: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
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
                          style: const TextStyle(fontSize: 16),
                          width: 150,
                        ),
                        AccountInfoRow(
                          label: 'Nhà cung cấp:',
                          value: 'Công ty xxx',
                          style: const TextStyle(fontSize: 16),
                          width: 150,
                        ),
                        AccountInfoRow(
                          label: 'Nhà xuất bản:',
                          value: 'Kim Đồng',
                          style: const TextStyle(fontSize: 16),
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
                        const TextInfo(
                          label: 'Mô tả:',
                          style: TextStyle(
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CartItemWidget(
                            initialQuantity: _quantity,
                            onQuantityChanged: (newQuantity) {
                              setState(() {
                                _quantity = newQuantity;
                              });
                            },
                          ),
                          Button(
                            width: 200,
                            height: 40,
                            text: 'Mua Ngay',
                            onPressed: _buyNow,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: primaryColor,
        backgroundColor: Colors.white,
        onPressed: () {
          print(_id);
          print(widget.book.id);
          print(_quantity);
          addItemToCart();
        },
        child: const Icon(CupertinoIcons.cart),
      ),
    );
  }
}

class CartItemWidget extends StatefulWidget {
  final int initialQuantity;
  final ValueChanged<int> onQuantityChanged;

  const CartItemWidget({
    super.key,
    required this.initialQuantity,
    required this.onQuantityChanged,
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
      widget.onQuantityChanged(quantity);
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        widget.onQuantityChanged(quantity);
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

  const TextInfo({super.key, required this.label, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style,
    );
  }
}
