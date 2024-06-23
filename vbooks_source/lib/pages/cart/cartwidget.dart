import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: CartWidget(),
  ));
}

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(21, 139, 125, 1)),
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước đó
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                CartItemWidget(
                  imageUrl:
                      "https://bizweb.dktcdn.net/thumb/large/100/197/269/products/tam-ly-hoc-thanh-cong-304x472.jpg?v=1516592128997",
                  name: "Red Queen",
                  price: 100000,  
                  initialQuantity: 1,
                ),
                CartItemWidget(
                  imageUrl:
                      "https://static.oreka.vn/800-800_0fa33f3c-4354-4a55-ad59-868547814f67",
                  name: "To Kill A Mockingbird",
                  price: 2000,
                  initialQuantity: 2,
                ),
                CartItemWidget(
                  imageUrl:
                      "https://www.elleman.vn/wp-content/uploads/2019/12/05/cho-sua-nham-cay-sach-tam-ly-elleman-1119-Vidoda.jpg",
                  name: "How to Drink",
                  price: 95000,
                  initialQuantity: 1,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            constraints: BoxConstraints(minHeight: 10.0, maxHeight: double.infinity),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Total:                                            800.000 đ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                 onPressed: () {
                    
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

class CartItemWidget extends StatefulWidget {
  final String name;
  final int price;
  final int initialQuantity;
  final String imageUrl;

  const CartItemWidget({
    super.key,
    required this.name,
    required this.price,
    required this.initialQuantity,
    required this.imageUrl,
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
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          widget.imageUrl,
          width: 70,
          height: 120,
          fit: BoxFit.cover,
        ),
        title: Text(widget.name),
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
        trailing: Text(
          '${widget.price * quantity} đ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


