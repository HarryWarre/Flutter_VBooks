import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/services/apiservice.dart';
import 'package:vbooks_source/viewmodel/orderviewmodel.dart';
import 'package:vbooks_source/pages/order/orderdetailpage.dart';

import '../account/authwidget.dart';

class OrderMainPage extends StatefulWidget {
  const OrderMainPage({super.key});

  @override
  State<OrderMainPage> createState() => _OrderMainPageState();
}

class _OrderMainPageState extends State<OrderMainPage>
    with SingleTickerProviderStateMixin {
  String token = '';
  String email = '';
  String fullName = '';
  String address = '';
  String _accountId = '';

  TabController? _tabController;
  List<Map<String, dynamic>> allOrders = [];
  List<Map<String, dynamic>> filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _loadToken().then((_) {
      _tabController =
          TabController(length: 4, vsync: this); // Khởi tạo TabController
      _tabController?.addListener(_filterOrders);
      _fetchOrders();
    });
  }

  @override
  void dispose() {
    _tabController?.removeListener(_filterOrders);
    _tabController?.dispose();
    super.dispose();
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
          email = jwtDecodedToken['email'] ?? '...';
          fullName = jwtDecodedToken['fullName'] ?? '...';
          address = jwtDecodedToken['address'] ?? '...';
          _accountId = jwtDecodedToken['_id'];
          print(fullName + address + _accountId);
          print(token);
        });
      }
    } else {
      setState(() {
        token = 'Invalid token';
      });
    }
  }

  void _filterOrders() {
    setState(() {
      switch (_tabController?.index) {
        case 1:
          filteredOrders = allOrders
              .where((order) => order['status'] == 'Đang xử lý')
              .toList();
          break;
        case 2:
          filteredOrders = allOrders
              .where((order) => order['status'] == 'Hoàn tất')
              .toList();
          break;
        case 3:
          filteredOrders =
              allOrders.where((order) => order['status'] == 'Bị hủy').toList();
          break;
        default:
          filteredOrders = allOrders;
      }
    });
  }

  Future<void> _fetchOrders() async {
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
    await orderViewModel.fetchOrders(_accountId); // Replace with actual user ID
    setState(() {
      allOrders = orderViewModel.orders;
      _filterOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Đơn hàng',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 14.0),
            indicatorColor: Color(0xFF158B7D),
            labelColor: Color(0xFF158B7D),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Tất cả'),
              Tab(text: 'Đang xử lý'),
              Tab(text: 'Hoàn tất'),
              Tab(text: 'Bị hủy'),
            ],
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          itemCount: filteredOrders.length,
          itemBuilder: (context, index) {
            final order = filteredOrders[index];
            return OrderContainer(
              idDonHang: order['_id']!,
              ngayDat: order['orderDate']!,
              nguoiDat: fullName, // Sử dụng fullName ở đây
              tongTien: order['totalAmount'].toString(),
              trangThai: order['status']!,
            );
          },
        ),
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {
  final String idDonHang;
  final String ngayDat;
  final String nguoiDat;
  final String tongTien;
  final String trangThai;

  const OrderContainer({
    required this.idDonHang,
    required this.ngayDat,
    required this.nguoiDat,
    required this.tongTien,
    required this.trangThai,
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

    // Convert the date to DD/MM/YYYY format
    DateTime dateTime = DateTime.parse(ngayDat);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    // Format the total amount to Vietnamese currency format
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    String formattedTotalAmount = numberFormat.format(double.parse(tongTien.replaceAll(',', '')));

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailPage(
              idDonHang: idDonHang,
              ngayDat: ngayDat,
              nguoiDat: nguoiDat,
              tongTien: tongTien,
              trangThai: trangThai,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        height: 180,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idDonHang,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ngày mua: $formattedDate',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Người nhận: $nguoiDat',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tổng tiền: $formattedTotalAmount',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      trangThai,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


