import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vbooks_source/pages/cart/cartlist.dart';
import '../../data/model/cartmodel.dart';
import '../../data/model/productmodel.dart';
import '../../viewmodel/cartviewmodel.dart';
import '../../viewmodel/productviewmodel.dart';

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
    _productViewModel = ProductViewModel();
    quantity = widget.quantity;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchProductById(widget.cart.productId!);
    });
  }

  Future<void> _fetchProductById(String productId) async {
    await _productViewModel.fetchProductsById(productId);
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
    _updateCartItemQuantity();
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
      _updateCartItemQuantity();
    }
  }

  Future<void> _updateCartItemQuantity() async {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    await cartViewModel.updateCartItemQuantity(widget.cart.id!, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductViewModel>.value(
      value: _productViewModel,
      child: Card(
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildCartItem(
                      product,
                      product.img!,
                      quantity,
                      _increaseQuantity,
                      _decreaseQuantity,
                      () async {
                        final cartViewModel =
                            Provider.of<CartViewModel>(context, listen: false);
                        await cartViewModel.deleteCartItem(widget.cart.id!);
                      },
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
