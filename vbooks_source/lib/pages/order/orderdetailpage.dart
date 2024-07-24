import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/conf/const.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/services/orderservice.dart';
import 'package:vbooks_source/viewmodel/orderdetailviewmodel.dart';

import '../../services/apiservice.dart';
import '../../services/paymentservice.dart';

class OrderDetailPage extends StatefulWidget {
  final String idDonHang;
  final String ngayDat;
  final String nguoiDat;
  final String tongTien;
  String trangThai;

  OrderDetailPage({
    required this.idDonHang,
    required this.ngayDat,
    required this.nguoiDat,
    required this.tongTien,
    required this.trangThai,
  });

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  String address = '';
  String phoneNumber = '';
  late PaymentService paymentService;
  bool isPaymentServiceInitialized = false;
  late OrderService orderService;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _initializePaymentService();
    orderService = OrderService(ApiService());

    Future.microtask(() =>
        Provider.of<OrderDetailViewModel>(context, listen: false)
            .fetchOrderDetails(widget.idDonHang));
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    if (storedToken != null && storedToken.isNotEmpty) {
      if (!JwtDecoder.isExpired(storedToken)) {
        Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(storedToken);
        setState(() {
          address = jwtDecodedToken['address'] ?? '...';
          phoneNumber = jwtDecodedToken['phoneNumber'] ?? '...';
        });
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ));
      }
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AuthScreen(),
      ));
    }
  }

  void _initializePaymentService() {
    final apiService = ApiService();
    paymentService = PaymentService(apiService);
    setState(() {
      isPaymentServiceInitialized = true;
    });
  }

  void _cancelOrder() async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text('Bạn muốn hủy đơn hàng này?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton(
                  child: const Text(
                    'Không',
                    style: TextStyle(color: Color(0xFF158B7D), fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    side: BorderSide(color: Color(0xFF158B7D)),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF158B7D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  ),
                  child: const Text(
                    'Có',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    try {
                      await orderService.updateOrderStatus(
                        orderId: widget.idDonHang,
                        status: 'Bị hủy',
                      );
                      setState(() {
                        widget.trangThai = 'Bị hủy';
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Không thể hủy đơn hàng: $e')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    if (!isPaymentServiceInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    Color statusColor;
    switch (widget.trangThai) {
      case 'Đang xử lý':
        statusColor = Color(0xFFEFCC11);
        break;
      case 'Bị hủy':
        statusColor = Color(0xFFFF0808);
        break;
      default:
        statusColor = Color(0xFF158B7D);
    }

    DateTime dateTime = DateTime.parse(widget.ngayDat);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết đơn hàng',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThongTinDonHang(
                    idDonHang: widget.idDonHang,
                    ngayDat: widget.ngayDat,
                    nguoiDat: widget.nguoiDat,
                    tongTien: widget.tongTien,
                    trangThai: widget.trangThai,
                    paymentId: widget.idDonHang,
                    paymentService: paymentService,
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: const Text(
                      'Thông tin người nhận',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ThongTinNguoiDat(
                    nguoiDat: widget.nguoiDat,
                    diaChi: address,
                    soDienThoai: phoneNumber,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: const Text(
                      'Sản phẩm đã mua',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<OrderDetailViewModel>(
                    builder: (context, orderDetailViewModel, child) {
                      if (orderDetailViewModel.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (orderDetailViewModel.errorMessage.isNotEmpty) {
                        return Center(
                            child: Text(orderDetailViewModel.errorMessage));
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: orderDetailViewModel.orderDetails.length,
                          itemBuilder: (context, index) {
                            final orderDetail =
                                orderDetailViewModel.orderDetails[index];
                            return SanPhamDaMua(
                              tenSach: orderDetail['productName'],
                              gia: NumberFormat.currency(
                                      locale: 'vi', symbol: '₫')
                                  .format(orderDetail['price']),
                              soLuong: orderDetail['quantity'],
                              urlHinh: orderDetail['productImage'],
                            );
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
          if (widget.trangThai == 'Đang xử lý')
            Container(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _cancelOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'Hủy đơn hàng',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ThongTinDonHang extends StatelessWidget {
  final String idDonHang;
  final String ngayDat;
  final String nguoiDat;
  final String tongTien;
  final String trangThai;
  final String paymentId;
  final PaymentService paymentService;

  const ThongTinDonHang({
    required this.idDonHang,
    required this.ngayDat,
    required this.nguoiDat,
    required this.tongTien,
    required this.trangThai,
    required this.paymentId,
    required this.paymentService,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (trangThai) {
      case 'Đang xử lý':
        statusColor = Color(0xFFEFCC11);
        break;
      case 'Bị hủy':
        statusColor = Color(0xFFFF0808);
        break;
      default:
        statusColor = Color(0xFF158B7D);
    }

    DateTime dateTime = DateTime.parse(ngayDat);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    String formattedTotal = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(double.tryParse(tongTien) ?? 0);

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mã đơn hàng: $idDonHang',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Đơn hàng $trangThai',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text('Ngày mua: $formattedDate', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Tổng tiền: $formattedTotal', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Phương thức vận chuyển: Giao hàng tiêu chuẩn',
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          // FutureBuilder<String>(
          //   future: paymentService.fetchPaymentNameById(paymentId),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(child: CircularProgressIndicator());
          //     } else if (snapshot.hasError) {
          //       return Text('Lỗi: ${snapshot.error}',
          //           style: TextStyle(fontSize: 16));
          //     } else if (snapshot.hasData) {
          //       return Text(
          //         'Phương thức thanh toán: ${snapshot.data}',
          //         style: TextStyle(fontSize: 16),
          //       );
          //     } else {
          //       return Text('Phương thức thanh toán không có',
          //           style: TextStyle(fontSize: 16));
          //     }
          //   },
          // ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class ThongTinNguoiDat extends StatelessWidget {
  final String nguoiDat;
  final String diaChi;
  final String soDienThoai;

  const ThongTinNguoiDat({
    required this.nguoiDat,
    required this.diaChi,
    required this.soDienThoai,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFE5E5E5), width: 1),
          bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text('Người nhận: $nguoiDat', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Địa chỉ: $diaChi', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Số điện thoại: $soDienThoai', style: TextStyle(fontSize: 16)),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class SanPhamDaMua extends StatelessWidget {
  final String tenSach;
  final String gia;
  final int soLuong;
  final String urlHinh;

  const SanPhamDaMua({
    required this.tenSach,
    required this.gia,
    required this.soLuong,
    required this.urlHinh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
            top: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              urlHinh,
              width: 50,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 150,
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
          SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 100,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tenSach,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Giá: $gia', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Text('Số lượng: $soLuong', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
