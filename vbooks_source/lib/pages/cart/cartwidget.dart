import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/conf/const.dart';
import 'package:vbooks_source/data/model/cartmodel.dart';
import 'package:vbooks_source/data/model/productmodel.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/pages/cart/cartlist.dart';
import 'package:vbooks_source/pages/components/productcard.dart';
import 'package:vbooks_source/pages/order/deliveryinformation.dart';
import 'package:vbooks_source/services/apiservice.dart';
import 'package:vbooks_source/services/cartservice.dart';
import 'package:vbooks_source/viewmodel/cartviewmodel.dart';
import 'package:vbooks_source/viewmodel/productviewmodel.dart';

void main() {
  runApp(const MaterialApp(
    home: CartWidget(),
  ));
}

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  String _accountId = '';
  late SharedPreferences prefs;
  late ApiService _apiService;
  String _token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
    initSharedPref();
    _apiService = ApiService();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _fetchCart() async {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    await cartViewModel.fetchCartByIdAccount(_accountId);
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    if (storedToken != null && storedToken.isNotEmpty) {
      if (JwtDecoder.isExpired(storedToken)) {
        setState(() {
          _token = 'Invalid token';
        });

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ));
      } else {
        setState(() {
          _token = storedToken;
          Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(_token);
          _accountId = jwtDecodedToken['_id'];
          _fetchCart();
          print('Account ID: ' + _accountId);
        });
      }
    } else {
      setState(() {
        _token = 'Invalid token';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Giỏ hàng',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cartViewModel, child) {
          if (cartViewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (cartViewModel.carts.isEmpty) {
            return const Center(
              child: Text('Không có sản phẩm trong giỏ hàng'),
            );
          } else {
            final carts = cartViewModel.carts;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: carts.length,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  cart: carts[index],
                  quantity: carts[index].quantity!,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CartItemWidget extends StatefulWidget {
  final Cart cart;
  final int quantity;

  const CartItemWidget({super.key, required this.cart, required this.quantity});

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late int quantity;
  late ProductViewModel _productViewModel;

  @override
  void initState() {
    super.initState();
    _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    quantity = widget.quantity;  
    _fetchProductById(widget.cart.productId!);  
  }

  Future<void> _fetchProductById(String productId) async {
    await  _productViewModel.fetchProductsById(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: Consumer<ProductViewModel>(
        builder: (context, productViewModel, child) {
          if (productViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productViewModel.products.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            return Column(
              children: productViewModel.products.map((product) {
                print(product.catId);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildCartItem(product,'assets/images/product/doraemon.jpeg', quantity,() { }),
                );
              }).toList(),
              
            );
          }
        },
      ),
    );
  }
}
