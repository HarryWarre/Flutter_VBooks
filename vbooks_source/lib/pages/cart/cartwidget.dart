import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/order/deliveryinformation.dart';
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
  List<CartItem> cartItems = [
    CartItem(
      imageUrl: "https://bizweb.dktcdn.net/thumb/large/100/197/269/products/tam-ly-hoc-thanh-cong-304x472.jpg?v=1516592128997",
      name: "Red Queen",
      price: 100000,
      quantity: 1,
    ),
    CartItem(
      imageUrl: "https://static.oreka.vn/800-800_0fa33f3c-4354-4a55-ad59-868547814f67",
      name: "To Kill A Mockingbird",
      price: 2000,
      quantity: 2,
    ),
    CartItem(
      imageUrl: "https://www.elleman.vn/wp-content/uploads/2019/12/05/cho-sua-nham-cay-sach-tam-ly-elleman-1119-Vidoda.jpg",
      name: "How to Drink",
      price: 95000,
      quantity: 1,
    ),
  ];

  void _removeCartItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  cartItem: cartItems[index],
                  onRemove: () => _removeCartItem(index),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            constraints: BoxConstraints(minHeight: 10.0, maxHeight: double.infinity),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total:                                            ${cartItems.fold<int>(0, (total, item) => total + item.price * item.quantity)} đ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShippingInfoWidget()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 20),
                    backgroundColor: const Color.fromRGBO(21, 139, 125, 1),
                  ),
                  child: const Text(
                    'Thanh toán',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25.0),
        ],
      ),
    );
  }
}

class CartItem {
  final String name;
  final int price;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onRemove,
  });

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartItem.quantity;
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
      widget.cartItem.quantity = quantity;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        widget.cartItem.quantity = quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          widget.cartItem.imageUrl,
          width: 70,
          height: 120,
          fit: BoxFit.cover,
        ),
        title: Text(widget.cartItem.name),
        subtitle: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: _decrementQuantity,
            ),
            Text('$quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _incrementQuantity,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.cartItem.price * quantity} đ',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color:  Color.fromRGBO(21, 139, 125, 1)),
              onPressed: widget.onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
