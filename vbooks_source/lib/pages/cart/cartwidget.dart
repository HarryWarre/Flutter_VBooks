import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/services/apiservice.dart';
import 'package:vbooks_source/viewmodel/cartviewmodel.dart';

import 'cartItem.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadToken();
      initSharedPref();
      _apiService = ApiService();
    });
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _fetchCart() async {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    await cartViewModel.fetchCartByIdAccount(_accountId);
    print(cartViewModel.carts);
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
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
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
