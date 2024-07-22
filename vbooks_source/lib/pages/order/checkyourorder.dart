import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/data/model/orderItem.dart';
import 'package:vbooks_source/viewmodel/orderviewmodel.dart';
import '../../data/model/productmodel.dart';
import '../../viewmodel/productviewmodel.dart';
import '../../viewmodel/orderitemviewmodel.dart';
import '../account/authwidget.dart';
import 'listorderdetail.dart';
import 'successcheckout.dart';

class OrderReviewPage extends StatefulWidget {
  final String paymentMethodId;
  final String paymentMethodName;
  final List<OrderItem> orderItems;

  const OrderReviewPage({
    super.key,
    required this.paymentMethodId,
    required this.paymentMethodName,
    required this.orderItems,
  });

  @override
  _OrderReviewPageState createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kiểm tra đơn hàng'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(21, 139, 125, 1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StepWidget(
                    stepNumber: 1, step: 'Thanh toán', isCompleted: true),
                StepWidget(stepNumber: 2, step: 'Kiểm tra', isCompleted: true),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: OrderReviewForm(
                paymentMethodName: widget.paymentMethodName,
                orderItems: widget.orderItems,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  final int stepNumber;
  final String step;
  final bool isCompleted;

  const StepWidget({
    required this.stepNumber,
    required this.step,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor:
              isCompleted ? Color.fromRGBO(21, 139, 125, 1) : Colors.grey,
          child: Text(stepNumber.toString(),
              style: TextStyle(color: Colors.white)),
        ),
        SizedBox(height: 5.0),
        Text(step),
      ],
    );
  }
}

class OrderReviewForm extends StatefulWidget {
  final String paymentMethodName;
  final List<OrderItem> orderItems;

  const OrderReviewForm({
    super.key,
    required this.paymentMethodName,
    required this.orderItems,
  });

  @override
  _OrderReviewFormState createState() => _OrderReviewFormState();
}

class _OrderReviewFormState extends State<OrderReviewForm> {
  String token = '';
  String email = '';
  String fullName = '';
  String address = '';
  String id = '';
  Map<String, Product> productsMap = {};

  late ProductViewModel productViewModel;
  late OrderViewModel orderViewModel;
  late OrderItemViewModel orderItemViewModel;

  @override
  void initState() {
    super.initState();
    productViewModel = ProductViewModel();
    orderViewModel = OrderViewModel();
    orderItemViewModel = OrderItemViewModel();
    _loadToken();
    fetchProductDetails();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    if (storedToken != null && !JwtDecoder.isExpired(storedToken)) {
      setState(() {
        token = storedToken;
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        email = decodedToken['email'] ?? '...';
        fullName = decodedToken['fullName'] ?? '...';
        address = decodedToken['address'] ?? '...';
        id = decodedToken['_id'] ?? '...';
      });
    } else {
      setState(() => token = 'Invalid token');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthScreen()));
    }
  }

  Future<void> fetchProductDetails() async {
    final productIds = widget.orderItems.map((item) => item.productId).toSet();

    for (final productId in productIds) {
      try {
        await productViewModel.fetchProductsById(productId);
        final product = productViewModel.products.firstWhere(
          (prod) => prod.id == productId,
          orElse: () => Product(id: '', price: 0),
        );
        // Lưu thông tin sản phẩm vào map
        productsMap[product.id!] = product;
      } catch (e) {
        _showErrorDialog('Không thể tải sản phẩm với ID: $productId');
        return;
      }
    }
    setState(() {}); // Cập nhật trạng thái để hiển thị dữ liệu mới
  }

  double _calculateTotalAmount() {
    return widget.orderItems.fold(0.0, (total, item) {
      final product = productViewModel.products.firstWhere(
        (prod) => prod.id == item.productId,
        orElse: () => Product(id: '', name: 'Unknown', img: '', price: 0),
      );
      return total + product.price! * item.quantity;
    });
  }

  Future<String?> _fetchLastOrderId(String userId) async {
    await orderViewModel.fetchOrders(userId);
    return orderViewModel.orders.isNotEmpty
        ? orderViewModel.orders.last['_id']
        : null;
  }

  Future<void> _processOrderItems(String orderId) async {
    final productIds = widget.orderItems.map((item) => item.productId).toSet();

    for (final productId in productIds) {
      try {
        await productViewModel.fetchProductsById(productId);
      } catch (e) {
        _showErrorDialog('Không thể tải sản phẩm với ID: $productId');
        return;
      }
    }

    for (final item in widget.orderItems) {
      final product = productViewModel.products.firstWhere(
        (prod) => prod.id == item.productId,
        orElse: () => Product(id: '', price: 0),
      );
      if (product.id == null) {
        _showErrorDialog('Không tìm thấy sản phẩm với ID: ${item.productId}');
        return;
      }

      try {
        await orderItemViewModel.addOrderItem(
          orderId: orderId,
          productId: item.productId,
          quantity: item.quantity,
          unitPrice: product.price!,
        );
      } catch (e) {
        _showErrorDialog('Không thể thêm sản phẩm vào đơn hàng.');
        return;
      }
    }
  }

  Future<void> _createOrder() async {
    double totalAmount = _calculateTotalAmount();
    if (totalAmount == 0.0) {
      _showErrorDialog('Tổng số tiền không hợp lệ.');
      return;
    }

    try {
      await orderViewModel.createOrder(
        userId: id,
        status: 'Đang xử lý',
        paymentMethodId: '668d66ac3b5afab5f09ef44b',
        totalAmount: totalAmount,
      );

      String? orderId = await _fetchLastOrderId(id);
      if (orderId == null) {
        _showErrorDialog('Không thể tạo đơn hàng. Danh sách đơn hàng trống.');
        return;
      }

      await _processOrderItems(orderId);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OrderSuccessPage()));
    } catch (e) {
      _showErrorDialog('Có lỗi đã xảy ra khi tạo đơn hàng: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Lỗi'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Đóng')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductViewModel>.value(
      value: productViewModel,
      child: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              Text('Thông tin giao hàng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              // Hiển thị thông tin giao hàng
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tên đầy đủ: $fullName',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8.0),
                    Text('Địa chỉ: $address', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8.0),
                    Text('Email: $email', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text('Phương thức thanh toán',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListTile(title: Text(widget.paymentMethodName)),
              SizedBox(height: 16.0),
              Text('Danh sách mặt hàng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 32.0),

              // Hiển thị danh sách sản phẩm
              ...widget.orderItems.map((item) {
                final product = productsMap[item.productId];
                return ProductListTile(
                  product: product!,
                  quantity: item.quantity,
                );
              }).toList(),

              ElevatedButton(
                onPressed: _createOrder,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Color.fromRGBO(21, 139, 125, 1),
                ),
                child: const Text('Xác nhận đơn hàng',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }
}
